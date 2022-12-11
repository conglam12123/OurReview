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
    public partial class WebForm3 : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["db_webnc"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                changeAvatarGr.Visible = false;
                changeNameGr.Visible = false;
                if ((int)Session["user_id"] == 0)
                {
                    Response.Redirect("~/Login.aspx");
                }
                else
                {
                    KhoiTaoDuLieu();

                }
            }
        }

        protected void KhoiTaoDuLieu()
        {
            SqlConnection Cnn = new SqlConnection(connectionString);
            SqlCommand Cmd = new SqlCommand("sp_tblUser_avartar", Cnn);
            Cmd.CommandType = CommandType.StoredProcedure;
            Cmd.Parameters.AddWithValue("@userID", (int)Session["user_id"]);
            Cnn.Open();
            int i = Cmd.ExecuteNonQuery();
            rptInforGr.DataSource = Cmd.ExecuteReader();
            rptInforGr.DataBind();
            Cnn.Close();
            Cnn.Dispose();
        }

        protected void rptInforGr_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            //  txtName.Text = Session["user_name"].ToString();
        }

        protected void rptInforGr_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

        }

        protected void btnUpdateName_Click(object sender, EventArgs e)
        {

            using (SqlConnection cnn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = cnn.CreateCommand())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "sp_tblUser_changeName";
                    cmd.Parameters.AddWithValue("@userID", Session["user_id"].ToString());
                    cmd.Parameters.AddWithValue("@userName", txtName.Text);
                    cnn.Open();
                    int result = cmd.ExecuteNonQuery();
                    if (result != 0)
                    {
                        Label1.Text = "Đổi tên thành công!";
                    }
                    else
                    {
                        Label1.Text = "Đổi tên thất bại!";
                    }
                    cnn.Close();

                    changeNameGr.Visible = false;
                }
            }
            KhoiTaoDuLieu();
        }

        protected void btnUpdateAvatar_Click(object sender, EventArgs e)
        {
            changeAvatarGr.Visible = true;
        }

        protected void btnUpdateNames_Click(object sender, EventArgs e)
        {
            txtName.Text = Session["user_name"].ToString();
            changeNameGr.Visible = true;
        }

        protected void btnUpdateAva_Click(object sender, EventArgs e)
        {
            string fileName = "./Assets/img/avatar/DefaultAvatar.png";
            if (fulAvatar.HasFile)
            {
                if (checkFileType(fulAvatar.FileName))
                {
                    fileName = "./Assets/img/avatar/" + DateTime.Now.ToString("ddMMyyyy_hhmmss_tt_") + fulAvatar.FileName;
                    String filePath = MapPath(fileName);
                    fulAvatar.SaveAs(filePath);
                }
            };

            if (InsertUser(fileName) != 0)
            {
                //Response.Write("<script>alert('Đổi ảnh đại diện thành công!')</script>");
                Label1.Text = "Đổi avatar thành công!";
                changeAvatarGr.Visible = false;

            }
            else
            {
                //Response.Write("<script>alert('Đổi ảnh đại diện thất bại!')</script>");
                Label1.Text = "Đổi avatar thất bại!";
            }
            KhoiTaoDuLieu();

        }
        private int InsertUser(string avatarPath)
        {
            using (SqlConnection cnn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = cnn.CreateCommand())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "sp_tblUser_changeAvatar";
                    cmd.Parameters.AddWithValue("@userID", Session["user_id"].ToString());
                    cmd.Parameters.AddWithValue("@userAvatar", avatarPath);
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

        protected void btnCancelUpdateName_Click(object sender, EventArgs e)
        {
            changeNameGr.Visible = false;
        }

        protected void btnCancelUpdateAva_Click(object sender, EventArgs e)
        {
            changeAvatarGr.Visible = false;
        }
    }
}