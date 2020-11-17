from fastapi import FastAPI 
import sqlite3
app = FastAPI()
from pydantic import BaseModel
import json
import collections


@app.get("/")
async def calculate():
    return {"result": 34*45}

@app.get('/signup')
async def signUp(first_name: str, last_name: str, username: str, password: str, email: str):
    try:
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

    except:
        return {"result": "Please write carefully"}

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

@app.get('/update_user')
async def update_user(pk, name, lastname, currentuser, username, password, currentemail, email):
    emails = email.split("@")
    message = ''
    conn = sqlite3.connect("website.db")
    userCheck = conn.execute("SELECT * FROM users WHERE username=?", [username])
    emailCheck = conn.execute("SELECT * FROM users WHERE email_header=? and email_footer=?", [email[0], email[1]])
    print(currentuser == username)
    
    print(currentemail == email)
    if (currentuser == username )and (currentemail == email):
        print("ENTERKJHDFKHs")
        conn.execute("UPDATE users SET firstName=?, lastName=?, userName=?, password=?, email_header=?, email_footer=? WHERE pk=?", [name,
        lastname, username, password, emails[0], emails[1], pk])        
        message = "user Update"
    elif userCheck.fetchall() == [] and emailCheck.fetchall() == []:
        conn.execute("UPDATE users SET firstName=?, lastName=?, userName=?, password=?, email_header=?, email_footer=? WHERE pk=?", [name,
        lastname, username, password, emails[0], emails[1], pk])        
        message = "user Update"

    else:
        message = "username or email exists"

    conn.commit()
    conn.close()
    return {"result": message}

@app.get("/get_pk")
async def get_primary_key(username):
    result = []
    conn = sqlite3.connect("website.db")
    curr = conn.execute("SELECT * FROM users WHERE userName=?", [username])
    for i in curr:
        result.append(i)
    conn.commit()
    conn.close()
    return {"result": result[0][6]}


@app.get("/donate_blood")
async def donate_blood_donor(username, name, gender, email, phone, weight, blood_group):
    conn = sqlite3.connect("website.db")    
    email = email.split("@")
    conn.execute("INSERT INTO dob (username, name, gender, email_header, email_footer, phone, weight, blood_group) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", [username, 
    name, gender, email[0], email[1], phone, weight, blood_group])
    conn.commit()
    conn.close()
    return {"result": "Sucessfully Added"}

@app.get("/get_group")
async def getgroup(blood_group: str):
    output = []
    conn = sqlite3.connect("website.db")
    rows = conn.execute("SELECT * FROM dob WHERE blood_group=?", [blood_group])
    objects_list = []
    for row in rows:
        d = collections.OrderedDict()
        d["username"] = row[0]
        d["name"] = row[1]
        d["gender"] = row[2]
        d["email"] = row[3]+"@"+row[4]
        d["phone"] = row[5]
        d["weight"] = row[6]
        d["blood_group"] = row[7]
        objects_list.append(d)
    conn.commit()
    conn.close()
    return objects_list