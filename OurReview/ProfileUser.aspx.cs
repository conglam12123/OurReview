using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OurReview
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int idProfile = Convert.ToInt32(Request["ProfileID1"]);
            RptSearch.DataSource = GetPostByUser(idProfile);
            RptSearch.DataBind();
        }
        private DataTable GetPostByUser(int userid)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["db_webnc"].ConnectionString;
            using (SqlConnection cnn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = cnn.CreateCommand())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "sp_showProfile";
                    cmd.Parameters.AddWithValue("@userid", userid);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable result = new DataTable();
                        da.Fill(result);
                        return result;
                    }
                }
            }
        }
    }
}