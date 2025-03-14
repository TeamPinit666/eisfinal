import { useState } from "react";
import { PieChart, Pie, Cell, Tooltip, ResponsiveContainer } from "recharts";
import DataTable from "./DataTable";

const COLORS = ["#0088FE", "#00C49F", "#FFBB28", "#FF8042"];

const FinancialChart = ({ data }) => {
  const [selectedReport, setSelectedReport] = useState(null);

  const handleClick = (entry) => {
    if (entry && entry.name) {
      setSelectedReport(entry);
    }
  };

  return (
    <div className="bg-white p-2 rounded shadow-md text-center">
      <h3 className="text-sm font-semibold">Financial Overview</h3>
      <ResponsiveContainer width="100%" height={120}>
        <PieChart>
          <Pie
            data={data}
            dataKey="value"
            nameKey="name"
            cx="50%"
            cy="50%"
            outerRadius={30}
          >
            {data.map((entry, index) => (
              <Cell
                key={`cell-${index}`}
                fill={COLORS[index % COLORS.length]}
                onClick={() => handleClick(entry)} // Pindahkan onClick ke dalam Cell
                style={{ cursor: "pointer" }} // Tambahkan efek pointer
              />
            ))}
          </Pie>
          <Tooltip />
        </PieChart>
      </ResponsiveContainer>

      {/* Tampilkan DataTable hanya jika ada data yang dipilih */}
      {selectedReport ? (
        <DataTable
          title={`Financial Report: ${selectedReport.name}`}
          type="financials"
          filterKey="report_type"
          filterValue={selectedReport.name}
        />
      ) : (
        <p className="text-sm text-gray-500 mt-2">
          Klik pada chart untuk melihat detail
        </p>
      )}
    </div>
  );
};

export default FinancialChart;
