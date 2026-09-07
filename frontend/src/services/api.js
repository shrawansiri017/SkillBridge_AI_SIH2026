const API_BASE = import.meta.env.VITE_API_BASE_URL || 'http://127.0.0.1:8000';

export async function apiHealth(){
  const response = await fetch(`${API_BASE}/api/health`);
  if(!response.ok) throw new Error('API unavailable');
  return response.json();
}

export async function scoreAssessment(payload){
  const response = await fetch(`${API_BASE}/api/assessment/score`,{
    method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify(payload)
  });
  if(!response.ok) throw new Error('Assessment service unavailable');
  return response.json();
}

export async function publishOpportunity(payload){
  const response = await fetch(`${API_BASE}/api/opportunities`,{
    method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify(payload)
  });
  if(!response.ok) throw new Error('Opportunity service unavailable');
  return response.json();
}
