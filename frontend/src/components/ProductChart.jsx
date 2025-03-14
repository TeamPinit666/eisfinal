import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from "recharts";

const ProductChart = ({ data }) => {
  return (
    <div className="bg-white p-2 rounded shadow-md text-center">
      <h3 className="text-sm font-semibold">Product Stock</h3>
      <ResponsiveContainer width="100%" height={120}>
        <BarChart data={data}>
          <CartesianGrid strokeDasharray="3 3" />
          <XAxis dataKey="name" />
          <YAxis />
          <Tooltip />
          <Legend />
          <Bar dataKey="stock" fill="#82ca9d" />
        </BarChart>
      </ResponsiveContainer>
    </div>
  );
};

export default ProductChart;
