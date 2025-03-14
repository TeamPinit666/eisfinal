const API_URL = "http://localhost:8080/api"; // Sesuaikan dengan backend

export const fetchEmployees = async () => {
  const res = await fetch(`${API_URL}/employees`);
  return res.json();
};

export const fetchFinancials = async () => {    
  const res = await fetch(`${API_URL}/financials`);
  return res.json();
};
