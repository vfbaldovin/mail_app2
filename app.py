import sqlalchemy
from flask import Flask, request, render_template, url_for, redirect

import pandas as pd
from extensions import db
import os
from main import update_send
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import or_

from models import Lecture, LectureCategory

app = Flask(__name__)
app.config.from_object('config')

db.init_app(app)


@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':

        email = request.form['email']

        # Initialize or load DataFrame
        if os.path.exists("docs/user_track.csv"):
            df = pd.read_csv("docs/user_track.csv")
        else:
            df = pd.DataFrame(columns=['Email', 'LastPage'])

        # Add new email with LastPage as 0
        new_row = pd.DataFrame({'Email': [email], 'LastPage': [0]})
        df = pd.concat([df, new_row], ignore_index=True)

        # Save DataFrame to CSV
        df.to_csv("docs/user_track.csv", index=False)
        update_send()
        return "Email added successfully!"

    lecture_categories = LectureCategory.query.all()
    category_names = {category.name: category.id for category in lecture_categories}

    genre = request.args.get('genre', default="Toate")
    if genre in category_names and genre != "Toate":
        lectures = Lecture.query.filter_by(id_category=category_names[genre]).all()
    else:
        lectures = Lecture.query.all()
        genre = "Toate"

    return render_template('index.html', lectures=lectures, lecture_categories=lecture_categories, selected_genre=genre)


@app.route('/books/search', methods=['GET'])
def search_lectures():
    query = request.args.get('search')

    lecture_categories = LectureCategory.query.all()

    if not query:
        # If no query is given, fetch all lectures and redirect to the homepage
        lectures = Lecture.query.all()
        return render_template('index.html', lectures=lectures, lecture_categories=lecture_categories,
                               selected_genre="Toate")

    # Filter lectures by title or author
    lectures = Lecture.query.filter(
        or_(Lecture.title.ilike(f"%{query}%"), Lecture.author.ilike(f"%{query}%"))
    ).all()

    # Return the same index.html but with the filtered lectures or all lectures if no results are found
    if not lectures:
        lectures = Lecture.query.all()
        no_results = True
    else:
        no_results = False

    return render_template('index.html', lectures=lectures, lecture_categories=lecture_categories,
                           selected_genre="Toate", no_results=no_results, query=query)



if __name__ == '__main__':
    app.run(debug=True)
