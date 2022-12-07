using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OurReview
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loginLink.HRef = ConfigurationManager.AppSettings["loginurl"];

            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string fileName = "./Assets/img/avatar/DefaultAvatar.png";
            if(fuUserAvatar.HasFile)
            {
                if (checkFileType(fuUserAvatar.FileName))
                {
                     fileName = "./Assets/img/avatar/" + DateTime.Now.ToString("ddMMyyyy_hhmmss_tt_") + fuUserAvatar.FileName;
                    String filePath = MapPath(fileName);
                    fuUserAvatar.SaveAs(filePath);
                }
            };
            if (InsertUser(fileName) != 0)
            {
                Response.Write("<script>alert('Đăng ký thành công! bạn sẽ được chuyển đến trang đăng nhập');" +
                    "location.replace('"+ConfigurationManager.AppSettings["loginurl"]+"')</script>");
            }
            else
            {
                Response.Write("<script>alert('Đăng ký không thành công! hãy thử lại sau')</script>");
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
        private int InsertUser(string avatarPath)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["db_webnc"].ConnectionString;
            using (SqlConnection cnn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = cnn.CreateCommand())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "sp_InsertUser";
                    cmd.Parameters.AddWithValue("@email",tbEmail.Text);
                    cmd.Parameters.AddWithValue("@password", md5Encrypt(tbPassword.Text));
                    cmd.Parameters.AddWithValue("@username", tbUsername.Text);
                    cmd.Parameters.AddWithValue("@avatar", avatarPath);
                    cnn.Open();
                    int result = 0;
                    try
                    {
                        result = cmd.ExecuteNonQuery();
                    }
                    catch
                    {
                        
                    }
                    cnn.Close();
                    return result;
                }
            }
        }

        protected String md5Encrypt(String password)
        {
            MD5 md5 = new MD5CryptoServiceProvider();

            md5.ComputeHash(UTF8Encoding.UTF8.GetBytes(password));

            byte[] result = md5.Hash;

            StringBuilder strBuilder = new StringBuilder();
            for (int i = 0; i < result.Length; i++)
            {
                strBuilder.Append(result[i].ToString("x2"));
            }
            return strBuilder.ToString();
        }

    }
}