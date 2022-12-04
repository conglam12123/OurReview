using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OurReview
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                registerLink.HRef = ConfigurationManager.AppSettings["registerurl"];
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            User_Login();
        }

        private void User_Login ()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["db_webnc"].ConnectionString;
            using (SqlConnection cnn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = cnn.CreateCommand())
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "sp_login";
                    cmd.Parameters.AddWithValue("@password", md5Encrypt(tbPassword.Text));
                    cmd.Parameters.AddWithValue("@email", tbEmail.Text);
                    cnn.Open();
                    using (SqlDataReader rd = cmd.ExecuteReader())
                    {
                        if (rd.HasRows)
                        {
                            rd.Read();
                            Session["user_id"] = rd.GetInt32(0);
                            Response.Write(Session["user_id"]);
                        }
                        else
                        {
                            lbError.Text = "Đăng nhập thất bại! Tên đăng nhập hoặc mật khẩu không đúng";
                        }
                    }
                    cnn.Close();
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