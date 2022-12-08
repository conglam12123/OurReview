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
    public partial class Index1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataTable categoriesTable = GetCategories();
                rptCategories.DataSource = categoriesTable;
                rptCategories.DataBind();
                foreach (DataRow row in categoriesTable.Rows)
                {
                    drlCategories.Items.Add(new ListItem(row["sCategoryName"].ToString(), row["PK_iCategoryID"].ToString()));
                }

                rptPostsByCategories.DataSource = categoriesTable;
                rptPostsByCategories.DataBind();
            }
        }
        private DataTable GetCategories()
        {
            String connectionString = ConfigurationManager.ConnectionStrings["db_webnc"].ConnectionString;
            using (SqlConnection cnn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = cnn.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "sp_getCategories";
                    DataTable dt = new DataTable();
                    cnn.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        cnn.Close();
                        da.Fill(dt);
                        return dt;
                    }
                }
            }
        }

        protected void rptPostsByCategories_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

            int idCate = Convert.ToInt32((e.Item.FindControl("hfCategoryID") as HiddenField).Value);
            Repeater rptPost = e.Item.FindControl("rptPostsOfCategories") as Repeater;
            rptPost.DataSource = getPosts(idCate);
            rptPost.DataBind();
        }

        private DataTable getPosts(int idCate)
        {
            using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["db_webnc"].ConnectionString))
            {
                using (SqlCommand cmd = cnn.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "sp_getPostByCategoryID";
                    cmd.Parameters.AddWithValue("@idCate", idCate);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        return dt;
                    }
                }
            }
        }
    }
}