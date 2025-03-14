import { useEffect, useState } from "react";
import { fetchEmployees, fetchFinancials } from "../api/api";
import EmployeeChart from "../components/EmployeeChart";
import FinancialChart from "../components/FinancialChart";
import ProductChart from "../components/ProductChart";
import BudgetChart from "../components/BudgetChart";

const Dashboard = () => {
  const [employeeData, setEmployeeData] = useState([]);
  const [financialData, setFinancialData] = useState([]);
  const [productData, setProductData] = useState([]);
  const [budgetData, setBudgetData] = useState([]);

  useEffect(() => {
    fetchEmployees().then(data => {
      const grouped = data.reduce((acc, emp) => {
        acc[emp.department_id] = (acc[emp.department_id] || 0) + 1;
        return acc;
      }, {});

      setEmployeeData(Object.keys(grouped).map(key => ({ name: `Dept ${key}`, value: grouped[key] })));
    });

    fetchFinancials().then(data => {
        setFinancialData(
          data.map((item, index) => ({
            name: item.description || `Report ${index + 1}`, // Gunakan description sebagai nama laporan
            value: item.revenue || 0,
          }))
        );
      });
      
      

    setProductData([{ name: "SS2", stock: 500 }, { name: "Munisi", stock: 20000 }, { name: "Anoa", stock: 10 }]);
    setBudgetData([{ name: "Produksi", allocated: 2000, used: 1500 }, { name: "Keuangan", allocated: 1000, used: 800 }, { name: "HRD", allocated: 500, used: 350 }]);
  }, []);

  return (
    <div className="flex flex-col items-center bg-gray-100 h-screen w-screen p-4">
      <h1 className="text-xl font-bold mb-2">Executive Information System</h1>
      <div className="grid grid-cols-4 gap-2 w-full h-full">
        <EmployeeChart data={employeeData} />
        <FinancialChart data={financialData} />
        <ProductChart data={productData} />
        <BudgetChart data={budgetData} />
      </div>
    </div>
  );
};

export default Dashboard;
