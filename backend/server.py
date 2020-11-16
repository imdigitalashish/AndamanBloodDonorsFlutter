from fastapi import FastAPI 
import sqlite3
app = FastAPI()


@app.get("/")
async def calculate():
    return {"result": 34*45}

@app.get('/signup')
async def signUp(first_name, last_name, username, password, email: str):
    conn = sqlite3.connect("website.db")
    email = email.split("@")   

    message = ""
    usernames = []
    # Validating user here
    userCheck = conn.execute("SELECT * FROM users WHERE username=?", [username])
    emailCheck = conn.execute("SELECT * FROM users WHERE email_header=? and email_footer=?", [email[0], email[1]])

    if userCheck.fetchall() == [] and emailCheck.fetchall() == []:
        conn.execute("INSERT INTO users (firstName, lastName, userName, password, email_header, email_footer) VALUES (?, ?, ?, ?, ?, ?)", [first_name, last_name, username, password, email[0], email[1]])
        message = "user created"

    else:
        message = "username or email exists"

    conn.commit()
    conn.close()
    return {"result": message}

@app.get("/login")
async def login(username, password):
    output = []
    conn = sqlite3.connect("website.db")
    cursor = conn.execute(f"SELECT * FROM users WHERE username=? and password=?", [username, password])
    for i in cursor:
        output.append(i)
    conn.commit()
    conn.close()
    if len(output) != 0:
        return {"result": "Success.. Loging in"}
    else:

        return {"result": "No User Exists"}


@app.get("/get_all_user")
async def get_all_users():
    conn = sqlite3.connect("website.db")
    cursor = conn.execute("SELECT * FROM users")
    result = []
    for i in cursor:
        result.append(i)
    conn.commit()
    conn.close()
    return result

@app.get("/delete_user")
async def delete_user(pk):
    conn  = sqlite3.connect("website.db")
    cursor = conn.execute("DELETE FROM users WHERE pk=?", [pk])
    conn.commit()
    conn.close()
    return {"result": "user deleted"}