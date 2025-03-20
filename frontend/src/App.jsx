import { useEffect, useState } from "react";
import {
  BarChart, Bar, XAxis, YAxis, Tooltip, Legend, ResponsiveContainer, CartesianGrid,
} from "recharts";

const API_URL = "http://localhost:8080/api";

const fetchEmployees = async () => {
  const res = await fetch(`${API_URL}/employees`);
  return res.json();
};

const fetchFinancials = async () => {
  const res = await fetch(`${API_URL}/financials`);
  return res.json();
};

const fetchBudgets = async () => {
  const res = await fetch(`${API_URL}/budgets`);
  return res.json();
};

// Fungsi format angka ke Rupiah
const formatRupiah = (value) => {
  if (!value) return "Rp 0";
  return `Rp ${value.toLocaleString("id-ID")}`;
};

// Custom Tooltip untuk Grafik Keuangan
const CustomTooltip = ({ active, payload }) => {
  if (active && payload && payload.length) {
    const data = payload[0]?.payload;
    return (
      <div className="bg-white p-3 border border-gray-300 shadow-md rounded text-sm">
        <p className="font-bold">Tanggal: {data?.report_date || "-"}</p>
        <p className="text-green-600">Pendapatan: {formatRupiah(data?.revenue)}</p>
        <p className="text-red-600">Pengeluaran (tanpa gaji): {formatRupiah(data?.expenses)}</p>
        <p className="text-orange-600 font-semibold">Gaji Karyawan: {formatRupiah(data?.total_salary)}</p>
        <p className="text-blue-600">Laba Bersih: {formatRupiah(data?.net_profit)}</p>
        <p className="text-purple-600">Aset: {formatRupiah(data?.assets)}</p>
      </div>
    );
  }
  return null;
};

function App() {
  const [employees, setEmployees] = useState([]);
  const [financials, setFinancials] = useState([]);
  const [budgets, setBudgets] = useState([]);
  const [totalSalary, setTotalSalary] = useState(0);
  const [latestFinancials, setLatestFinancials] = useState(null);
  const [totalAllocatedBudget, setTotalAllocatedBudget] = useState(0);
  const [totalUsedBudget, setTotalUsedBudget] = useState(0);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      try {
        // Fetch all data in parallel
        const [employeesData, budgetsData, financialsData] = await Promise.all([
          fetchEmployees(),
          fetchBudgets(),
          fetchFinancials()
        ]);

        // Process employees data
        setEmployees(employeesData);
        const salaryTotal = employeesData.reduce((sum, emp) => sum + (emp.salary || 0), 0);
        setTotalSalary(salaryTotal);

        // Process budgets data
        const formattedBudgets = budgetsData.map((budget) => ({
          department_name: budget.department?.name || "Unknown",
          allocated_budget: budget.allocated_budget || 0,
          used_budget: budget.used_budget || 0,
        }));
        setBudgets(formattedBudgets);
        
        const totalAllocated = formattedBudgets.reduce((sum, b) => sum + b.allocated_budget, 0);
        const totalUsed = formattedBudgets.reduce((sum, b) => sum + b.used_budget, 0);
        setTotalAllocatedBudget(totalAllocated);
        setTotalUsedBudget(totalUsed);

        // Process financials data with the updated totalSalary
        const updatedFinancials = financialsData.map((item) => ({
          ...item,
          total_salary: salaryTotal,
        }));
        setFinancials(updatedFinancials);
        
        if (financialsData.length > 0) {
          setLatestFinancials(financialsData[financialsData.length - 1]);
        }
      } catch (error) {
        console.error("Error fetching data:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  if (loading) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-gray-900"></div>
      </div>
    );
  }
  return (
    <div className="min-h-screen bg-gray-50 p-6">
      <header className="mb-8">
        <h1 className="text-3xl font-bold text-gray-800">Executive Dashboard</h1>
        <p className="text-gray-600 mt-2">Key metrics and financial overview</p>
      </header>

      {/* Key Metrics Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <div className="bg-white p-6 rounded-xl shadow-sm border-l-4 border-green-500">
          <h3 className="text-sm font-medium text-gray-500">Total Revenue</h3>
          <p className="mt-2 text-2xl font-semibold text-green-600">
            {formatRupiah(latestFinancials?.revenue || 0)}
          </p>
        </div>
        <div className="bg-white p-6 rounded-xl shadow-sm border-l-4 border-red-500">
          <h3 className="text-sm font-medium text-gray-500">Operational Expenses</h3>
          <p className="mt-2 text-2xl font-semibold text-red-600">
            {formatRupiah(latestFinancials?.expenses || 0)}
          </p>
        </div>
        <div className="bg-white p-6 rounded-xl shadow-sm border-l-4 border-orange-500">
          <h3 className="text-sm font-medium text-gray-500">Salary Expenses</h3>
          <p className="mt-2 text-2xl font-semibold text-orange-600">
            {formatRupiah(totalSalary)}
          </p>
        </div>
        <div className="bg-white p-6 rounded-xl shadow-sm border-l-4 border-blue-500">
          <h3 className="text-sm font-medium text-gray-500">Net Profit</h3>
          <p className="mt-2 text-2xl font-semibold text-blue-600">
            {formatRupiah(latestFinancials?.net_profit || 0)}
          </p>
        </div>
      </div>

      {/* Charts Grid */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8">
        <div className="bg-white p-6 rounded-xl shadow-sm">
          <h2 className="text-xl font-semibold mb-4">Financial Overview</h2>
          <div className="h-[400px]">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={financials} barGap={10} barCategoryGap={30}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="report_date" />
                <YAxis tickFormatter={formatRupiah} />
                <Tooltip content={<CustomTooltip />} />
                <Legend />
                <Bar dataKey="revenue" fill="#4CAF50" name="Pendapatan" />
                <Bar dataKey="expenses" fill="#F44336" name="Pengeluaran" />
                <Bar dataKey="total_salary" fill="#FF9800" name="Total Gaji" />
                <Bar dataKey="net_profit" fill="#2196F3" name="Laba Bersih" />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </div>

        <div className="bg-white p-6 rounded-xl shadow-sm">
          <h2 className="text-xl font-semibold mb-4">Department Budgets</h2>
          <div className="h-[400px]">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={budgets}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="department_name" />
                <YAxis tickFormatter={formatRupiah} />
                <Tooltip formatter={(value) => formatRupiah(value)} />
                <Legend />
                <Bar dataKey="allocated_budget" fill="#4CAF50" name="Anggaran Dialokasikan" />
                <Bar dataKey="used_budget" fill="#F44336" name="Anggaran Terpakai" />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </div>
      </div>

      {/* Employee Table */}
      <div className="bg-white rounded-xl shadow-sm p-6">
        <div className="flex justify-between items-center mb-4">
          <h2 className="text-xl font-semibold">Employee Directory</h2>
          <p className="text-sm text-gray-600">
            Total Employees: {employees.length}
          </p>
        </div>
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-4 py-3 text-left text-sm font-medium text-gray-500">NIK</th>
                <th className="px-4 py-3 text-left text-sm font-medium text-gray-500">Name</th>
                <th className="px-4 py-3 text-left text-sm font-medium text-gray-500">Position</th>
                <th className="px-4 py-3 text-left text-sm font-medium text-gray-500">Department</th>
                <th className="px-4 py-3 text-left text-sm font-medium text-gray-500">Salary</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-200">
              {employees.map((emp) => (
                <tr key={emp.nik} className="hover:bg-gray-50">
                  <td className="px-4 py-3 text-sm font-medium text-gray-900">{emp.nik}</td>
                  <td className="px-4 py-3 text-sm text-gray-900">{emp.full_name}</td>
                  <td className="px-4 py-3 text-sm text-gray-500">{emp.position?.name || "-"}</td>
                  <td className="px-4 py-3 text-sm text-gray-500">{emp.department?.name || "-"}</td>
                  <td className="px-4 py-3 text-sm text-blue-600 font-medium">
                    {formatRupiah(emp.salary)}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}

export default App;