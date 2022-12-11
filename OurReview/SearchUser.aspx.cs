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
    public partial class SearchUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string keywordSearch = Convert.ToString(Request["keyword"]);
            if ((int)Session["user_id"] == 0)
            {
                Response.Redirect("~/Login.aspx");
            }
            else
            {
                RptSearch.DataSource = GetUserByKeyword(keywordSearch);
                RptSearch.DataBind();
                int count = RptSearch.Items.Count;
                if (count != 0)
                {
                    lbMessage.Text = count.ToString();
                }
                lbMessage.Text = "(" + count.ToString() + " kết quả)";
            }
        }

        private DataTable GetUserByKeyword(string keyword)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["db_webnc"].ConnectionString;
            using (SqlConnection cnn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = cnn.CreateCommand())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "sp_tblUser_searchAccount";
                    cmd.Parameters.AddWithValue("@userName", keyword);
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