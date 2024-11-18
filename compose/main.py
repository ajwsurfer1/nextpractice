#!/usr/bin/env python3

from fastapi import FastAPI, Request, Depends
from fastapi.responses import HTMLResponse, FileResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
from pydantic import BaseModel
import couchdb

app = FastAPI()

# CouchDB connection setup
couch = couchdb.Server("http://admin:password@couchdb:5984/")  # CouchDB URL with credentials
try:
    db = couch.create("contact_db")  # Create database if it doesn’t exist
except couchdb.http.PreconditionFailed:
    db = couch["contact_db"]  # Use existing database if already created

# Static file mounts
app.mount("/public", StaticFiles(directory="public/"), name="public")
app.mount("/css", StaticFiles(directory="public/css"), name="css")
app.mount("/img", StaticFiles(directory="public/img"), name="img")
app.mount("/js", StaticFiles(directory="public/js"), name="js")

# Serve the favicon.ico file specifically
@app.get("/favicon.ico", include_in_schema=False)
async def favicon():
    return FileResponse("public/favicon.ico")

templates = Jinja2Templates(directory="public")

@app.get("/{full_path:path}", response_class=HTMLResponse)
async def root(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})

# Contact Form Model
class ContactForm(BaseModel):
    name: str
    email: str
    message: str

# Function to submit data to CouchDB
def submit_to_couchdb(data):
    # Create a new document with the data
    document = {
        "name": data["name"],
        "email": data["email"],
        "message": data["message"]
    }

    return db.save(document)

# Endpoint to store contact form data
@app.post("/api/contact")
async def submit_contact(form: ContactForm):
    contact_data = {
        "name": form.name,
        "email": form.email,
        "message": form.message
    }
    result = submit_to_couchdb(contact_data)
    return {"message": "Contact saved", "id": result}

