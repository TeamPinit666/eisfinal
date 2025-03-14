import { useEffect, useState } from "react";

const API_URL = "http://localhost:8080/api";

const DataTable = ({ title, type, filterKey, filterValue }) => {
  const [data, setData] = useState([]);

  useEffect(() => {
    if (!type) return;

    const fetchData = async () => {
      try {
        const res = await fetch(`${API_URL}/${type}`);
        const result = await res.json();

        // Jika ada filter, gunakan filter
        if (filterKey && filterValue) {
          setData(result.filter(item => item[filterKey] === filterValue));
        } else {
          setData(result);
        }
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    };

    fetchData();
  }, [type, filterKey, filterValue]);

  return (
    <div className="mt-2 bg-white p-2 rounded shadow-md w-full">
      <h3 className="text-sm font-semibold">{title}</h3>
      <table className="w-full text-left border-collapse">
        <thead>
          <tr className="bg-gray-200">
            {data.length > 0 &&
              Object.keys(data[0]).map((key, index) => (
                <th key={index} className="p-1 border">{key}</th>
              ))}
          </tr>
        </thead>
        <tbody>
          {data.length > 0 ? (
            data.map((row, rowIndex) => (
              <tr key={rowIndex} className="border-t">
                {Object.values(row).map((value, colIndex) => (
                  <td key={colIndex} className="p-1 border">{value}</td>
                ))}
              </tr>
            ))
          ) : (
            <tr>
              <td colSpan="100%" className="p-1 text-center">No data available</td>
            </tr>
          )}
        </tbody>
      </table>
    </div>
  );
};

export default DataTable;
