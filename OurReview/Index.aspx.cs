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
    public partial class Index1 : System.Web.UI.Page, ICallbackEventHandler
    {
        
        public const string DELETE_COMMAND_NAME = "delete";
        public const string LIKE_COMMAND_NAME = "like";
        public const string UNLIKE_COMMAND_NAME = "unlike";

        public string deletedPostID;

        private string m_callbackRef;
        private string m_callbackResult;

        public string CallbackRef { get => m_callbackRef; set => m_callbackRef = value; }

        protected void Page_Load(object sender, EventArgs e)
        {
            m_callbackRef = Page.ClientScript.GetCallbackEventReference(
                    this,
                    "args",
                    "callbackCompleted",
                    "context",
                    true
                );
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
                if (tbPostContent.Text=="")
                {
                    Response.Write("<script>alert('Hãy nhập nội dung bài viết!!');</script>");

                }
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
                    updateContent();
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

        protected void rptPostsOfCategories_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            // Chỉ hiện tùy chọn sửa/xóa với chủ bài viết 
            int idPost = Convert.ToInt32((e.Item.FindControl("hfPosterID") as HiddenField).Value);
            if (Session["user_id"] == "" || idPost != Convert.ToInt32(Session["user_id"]))
            {
                Label lbAlternate = e.Item.FindControl("lbAlternate") as Label;
                lbAlternate.Visible = false;
            }
            Panel pnPost = e.Item.FindControl("pnPost") as Panel;
        }


        public void RaiseCallbackEvent(string args)
        {
            string[] a = args.Split(':');
            switch (a[0])
            {
                case DELETE_COMMAND_NAME:
                    m_callbackResult = DeletePost(Convert.ToInt32(a[1])).ToString();
                    ; break;
                case LIKE_COMMAND_NAME:
                    LikePost(Convert.ToInt32(a[1])) ;
                    m_callbackResult = GetLike(Convert.ToInt32(a[1])).ToString();
                    break;
                case UNLIKE_COMMAND_NAME:
                    UnlikePost(Convert.ToInt32(a[1]));
                    m_callbackResult = GetLike(Convert.ToInt32(a[1])).ToString();
                    break;
            }

        }
        private int GetLike (int postID)
        {
            int result = 0 ;
            string connectionString = ConfigurationManager.ConnectionStrings["db_webnc"].ConnectionString;
            using (SqlConnection cnn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = cnn.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "sp_getPostLike";
                    cmd.Parameters.AddWithValue("@postid", postID);
                    cnn.Open();
                    SqlDataReader rd = cmd.ExecuteReader();
                    if (rd.HasRows)
                    {
                        while (rd.Read())
                        {
                            result = rd.GetInt32(1);
                        }
                    }
                    return result;
                    cnn.Close();
                }
            }
            
        }
        private int UnlikePost(int postID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["db_webnc"].ConnectionString;
            using (SqlConnection cnn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = cnn.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "sp_UnlikePost";
                    cmd.Parameters.AddWithValue("@postid", postID);
                    cmd.Parameters.AddWithValue("@userid", Convert.ToInt32(Session["user_id"]));
                    cnn.Open();
                    try
                    {
                        return cmd.ExecuteNonQuery();
                    }
                    catch
                    {
                        return 0;
                    }
                    cnn.Close();
                }
            }
        }

        private int LikePost(int postID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["db_webnc"].ConnectionString;
            using (SqlConnection cnn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = cnn.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "sp_LikePost";
                    cmd.Parameters.AddWithValue("@postid", postID);
                    cmd.Parameters.AddWithValue("@userid", Convert.ToInt32(Session["user_id"]));
                    cnn.Open();
                    try
                    {
                        return cmd.ExecuteNonQuery();
                    }
                    catch
                    {
                        return 0;
                    }
                    cnn.Close();
                }
            }
        }

        private int DeletePost(int postID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["db_webnc"].ConnectionString;
            using (SqlConnection cnn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = cnn.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "sp_deletePost";
                    cmd.Parameters.AddWithValue("@postid",postID);
                    cmd.Parameters.AddWithValue("@userid",Convert.ToInt32(Session["user_id"]));
                    cnn.Open();
                    try
                    {
                        return cmd.ExecuteNonQuery();
                    }
                    catch
                    {
                        return 0;
                    }
                    cnn.Close();
                }
            }
        }

        public string GetCallbackResult()
        {
            return m_callbackResult;
        }
        
        public void updateContent()
        {
            DataTable categoriesTable = GetCategories();
            rptPostsByCategories.DataSource = categoriesTable;
            rptPostsByCategories.DataBind();
        }
    }
}