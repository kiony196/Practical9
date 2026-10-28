
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Practical9
{
    public partial class Companies : Page
    {
        // Database Connection
        private string cs =
            @"Data Source=(localdb)\MSSQLLocalDB;
              Initial Catalog=Practical9;
              Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPlacements();
                LoadCompanies();
            }
        }

        // LOAD STUDENT PLACEMENT RECORDS
        private void LoadPlacements()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT
                        p.PlacementId,
                        p.StudentId,
                        s.StudentName,
                        p.CompanyName,
                        p.JobRole,
                        p.PackageLPA
                    FROM Placements p
                    INNER JOIN Students s
                        ON p.StudentId = s.StudentId
                    ORDER BY p.PlacementId;";

                using (SqlCommand cmd =
                    new SqlCommand(query, con))
                {
                    using (SqlDataAdapter da =
                        new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();

                        da.Fill(dt);

                        rptPlacements.DataSource = dt;
                        rptPlacements.DataBind();

                        if (dt.Rows.Count == 0)
                        {
                            lblMessage.Text =
                                "No placement records found.";
                        }
                    }
                }
            }
        }

        // LOAD COMPANY DETAILS USING DATALIST
        private void LoadCompanies()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT
                        CompanyName,
                        JobRole,
                        PackageLPA
                    FROM Placements
                    ORDER BY CompanyName, JobRole;";

                using (SqlCommand cmd =
                    new SqlCommand(query, con))
                {
                    using (SqlDataAdapter da =
                        new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();

                        da.Fill(dt);

                        dlCompanies.DataSource = dt;
                        dlCompanies.DataBind();
                    }
                }
            }
        }
    }
}
