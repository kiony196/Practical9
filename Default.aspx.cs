
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Practical9
{
    public partial class Default : Page
    {
        // Connection string
        private string cs =
            @"Data Source=(localdb)\MSSQLLocalDB;
              Initial Catalog=Practical9;
              Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSummary();
                LoadStudents();
            }
        }

        // LOAD PLACEMENT SUMMARY
        private void LoadSummary()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT
                        COUNT(*) AS TotalStudents,

                        SUM(
                            CASE
                                WHEN IsPlaced = 1 THEN 1
                                ELSE 0
                            END
                        ) AS PlacedStudents,

                        SUM(
                            CASE
                                WHEN IsPlaced = 0 THEN 1
                                ELSE 0
                            END
                        ) AS UnplacedStudents,

                        CAST(
                            100.0 *
                            SUM(
                                CASE
                                    WHEN IsPlaced = 1 THEN 1
                                    ELSE 0
                                END
                            ) /
                            NULLIF(COUNT(*), 0)
                            AS DECIMAL(5,2)
                        ) AS PlacementPercentage

                    FROM Students;";

                using (SqlCommand cmd =
                    new SqlCommand(query, con))
                {
                    con.Open();

                    using (SqlDataReader reader =
                        cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblTotalStudents.Text =
                                reader["TotalStudents"].ToString();

                            lblPlacedStudents.Text =
                                reader["PlacedStudents"] == DBNull.Value
                                ? "0"
                                : reader["PlacedStudents"].ToString();

                            lblUnplacedStudents.Text =
                                reader["UnplacedStudents"] == DBNull.Value
                                ? "0"
                                : reader["UnplacedStudents"].ToString();

                            lblPlacementPercentage.Text =
                                reader["PlacementPercentage"] == DBNull.Value
                                ? "0.00%"
                                : Convert.ToDecimal(
                                    reader["PlacementPercentage"]
                                  ).ToString("F2") + "%";
                        }
                    }
                }

                // HIGHEST PACKAGE
                // Separate query avoids nested aggregates
                string packageQuery = @"
                    SELECT ISNULL(MAX(PackageLPA), 0)
                    FROM Placements;";

                using (SqlCommand cmd =
                    new SqlCommand(packageQuery, con))
                {
                    object result = cmd.ExecuteScalar();

                    decimal highestPackage =
                        Convert.ToDecimal(result);

                    lblHighestPackage.Text =
                        highestPackage.ToString("F2");
                }
            }
        }

        // LOAD STUDENT RECORDS
        private void LoadStudents()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT
                        StudentId,
                        EnrollmentNo,
                        StudentName,
                        Department,
                        PassingYear,
                        IsPlaced
                    FROM Students
                    ORDER BY StudentId;";

                using (SqlCommand cmd =
                    new SqlCommand(query, con))
                {
                    using (SqlDataAdapter da =
                        new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();

                        da.Fill(dt);

                        gvStudents.DataSource = dt;
                        gvStudents.DataBind();
                    }
                }
            }
        }
    }
}
