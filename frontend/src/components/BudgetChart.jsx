import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from "recharts";

const BudgetChart = ({ data }) => {
  return (
    <div className="bg-white p-2 rounded shadow-md text-center">
      <h3 className="text-sm font-semibold">Department Budgets</h3>
      <ResponsiveContainer width="100%" height={120}>
        <BarChart data={data}>
          <CartesianGrid strokeDasharray="3 3" />
          <XAxis dataKey="name" />
          <YAxis />
          <Tooltip />
          <Legend />
          <Bar dataKey="allocated" fill="#8884d8" />
          <Bar dataKey="used" fill="#FF8042" />
        </BarChart>
      </ResponsiveContainer>
    </div>
  );
};

export default BudgetChart;
