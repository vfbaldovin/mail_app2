import sqlalchemy
from flask import Flask, request, render_template

import pandas as pd
from extensions import db
import os
from main import update_send
from flask_sqlalchemy import SQLAlchemy

from models import Lecture

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

    lectures = Lecture.query.all()

    return render_template('index.html', lectures=lectures)


if __name__ == '__main__':
    app.run(debug=True)