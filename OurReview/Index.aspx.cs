using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
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

        protected void btnCancelUpload_Click(object sender, EventArgs e)
        {

        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (Session["user_id"] != "")
            {
                string fileName = "";
                if (fuPostImage.HasFile)
                {
                    if (checkFileType(fuPostImage.FileName))
                    {
                        fileName = "./Assets/img/post" + DateTime.Now.ToString("ddMMyyyy_hhmmss_tt_") + fuPostImage.FileName;
                        String filePath = MapPath(fileName);
                        fuPostImage.SaveAs(filePath);
                    }
                };
                if (UploadPost(fileName) != 0)
                {
                    Response.Write("<script>alert('Đăng bài viết thành công! nội dung trang web sẽ sớm được cập nhật!');</script>");
                }
                else
                {
                    Response.Write("<script>alert('Thêm bài viết thất bại! hãy thử lại sau')</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('Bạn cần đăng nhập để đăng bài viết!')</script>");
            }
            
        }

        private int UploadPost(string fileName)
        {
            String connectionString = ConfigurationManager.ConnectionStrings["db_webnc"].ConnectionString;
            using (SqlConnection cnn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = cnn.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "sp_UploadPost";
                    cmd.Parameters.AddWithValue("@userid", Session["user_id"]);
                    cmd.Parameters.AddWithValue("@cateid", drlCategories.SelectedValue);
                    cmd.Parameters.AddWithValue("@postcontent", tbPostContent.Text);
                    cmd.Parameters.AddWithValue("@postImageUrl", fileName);
                    cnn.Open();
                    int result = cmd.ExecuteNonQuery();
                    cnn.Close();
                    return result;
                }
            }
        }

        protected bool checkFileType(string fileName)
        {
            String fileExtension = Path.GetExtension(fileName);
            if (fileExtension == ".jpg" || fileExtension == ".png" || fileExtension == ".jpeg")
            {
                return true;
            }
            else return false;
        }
    }
}