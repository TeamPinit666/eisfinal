import { useState } from "react";
import { PieChart, Pie, Cell, Tooltip, ResponsiveContainer } from "recharts";
import DataTable from "./DataTable";

const COLORS = ["#0088FE", "#00C49F", "#FFBB28", "#FF8042"];

const EmployeeChart = ({ data }) => {
  const [selectedDepartment, setSelectedDepartment] = useState(null);

  const handleClick = (entry) => {
    setSelectedDepartment(entry);
  };

  return (
    <div className="bg-white p-2 rounded shadow-md text-center">
      <h3 className="text-sm font-semibold">Employees per Department</h3>
      <ResponsiveContainer width="100%" height={120}>
        <PieChart>
          <Pie
            data={data}
            dataKey="value"
            nameKey="name"
            cx="50%"
            cy="50%"
            outerRadius={30}
            onClick={handleClick}
          >
            {data.map((entry, index) => (
              <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
            ))}
          </Pie>
          <Tooltip />
        </PieChart>
      </ResponsiveContainer>
      {selectedDepartment && (
        <DataTable
          title={`Employees in ${selectedDepartment.name}`}
          type="employees"
          filterKey="department_id"
          filterValue={parseInt(selectedDepartment.name.replace("Dept ", ""), 10)}
        />
      )}
    </div>
  );
};

export default EmployeeChart;
