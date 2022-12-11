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
    public partial class SearchPost : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["db_webnc"].ConnectionString;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            string keywordSearch = Convert.ToString(Request["keyword"]);

            if ((int)Session["user_id"] == 0)
            {
                Response.Redirect("~/Login.aspx");
            }
            else
            {
                RptSearch.DataSource = GetPostByKeyword(keywordSearch);
                RptSearch.DataBind();
                int count = RptSearch.Items.Count;
                if (count != 0)
                {
                    lbMessage.Text = count.ToString();
                }
                lbMessage.Text = "(" + count.ToString() + " kết quả)";
            }
        }

        private DataTable GetPostByKeyword(string keyword)
        {
            using (SqlConnection cnn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = cnn.CreateCommand())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "sp_searchByContent";
                    cmd.Parameters.AddWithValue("@content", keyword);
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