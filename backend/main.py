from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
from typing import List

app = FastAPI(title="SkillBridge AI API", version="1.0.0")
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class Assessment(BaseModel):
    student_id: str
    role: str
    scores: dict[str, int] = Field(default_factory=dict)

class Opportunity(BaseModel):
    title: str
    company: str
    type: str
    location: str
    skills: List[str]
    pay: str = ""

@app.get("/")
def root():
    return {"service":"SkillBridge AI","status":"online","ps_id":"SIH26044","team":"NEXORA"}

@app.get("/api/health")
def health():
    return {"status":"healthy","stack":["Python","FastAPI","PostgreSQL-ready","AI matching-ready"]}

@app.post("/api/assessment/score")
def score_assessment(payload: Assessment):
    if not payload.scores:
        return {"score":0,"gaps":[]}
    score = round(sum(max(0,min(5,v)) for v in payload.scores.values()) / (len(payload.scores)*5) * 100)
    gaps = [k for k,v in payload.scores.items() if v < 4]
    return {"score":score,"gaps":gaps,"student_id":payload.student_id,"role":payload.role}

@app.post("/api/opportunities")
def create_opportunity(payload: Opportunity):
    return {"success":True,"message":"Opportunity accepted by SkillBridge AI matching service","opportunity":payload.model_dump()}

@app.get("/api/candidates")
def candidates():
    return [
        {"name":"Aarav Mehta","role":"AI Engineer","compatibility":94,"readiness":91,"status":"Recommended"},
        {"name":"Ananya Rao","role":"AI Engineer","compatibility":91,"readiness":89,"status":"Recommended"},
        {"name":"Riya Sharma","role":"AI Engineer","compatibility":87,"readiness":84,"status":"Review"},
    ]
