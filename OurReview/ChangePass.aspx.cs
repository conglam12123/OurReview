using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OurReview
{
    public partial class ChangePass : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if ((int)Session["user_id"] == 0)
            {
                Response.Redirect("~/Login.aspx");
            }
            else
            {
                //Label1x.Text = Session["user_pass"].ToString();
            }
        }

        protected void btnDoiMatKhau_Click(object sender, EventArgs e)
        {
            string check = md5Encrypt(txtOldPass.Text);
            //Label1x.Text = check.ToString();
            if (check != Session["user_pass"].ToString())
            {
                lblRes.Text = "Mật khẩu cũ không chính xác";
            }
            else
            {
                String connectionString = ConfigurationManager.ConnectionStrings["db_webnc"].ConnectionString;
                SqlConnection myCnn = new SqlConnection(connectionString);
                myCnn.Open();
                SqlCommand myCmd = new SqlCommand("sp_userChangePass", myCnn);
                myCmd.CommandType = CommandType.StoredProcedure;
                myCmd.Parameters.AddWithValue("@pass", md5Encrypt(txtNewPass.Text.ToString()));
                myCmd.Parameters.AddWithValue("@userID", Convert.ToInt32(Session["user_id"]));
                int i = myCmd.ExecuteNonQuery();
                if (i != 0)
                {
                    lblRes.Text = "Đổi mật khẩu thành công";
                }
                else
                {
                    lblRes.Text = "Đổi mật khẩu thất bại";
                }
                myCmd.Dispose();
                myCnn.Close();
                myCnn.Dispose();

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

        protected void lbtnTrangChu_Click(object sender, EventArgs e)
        {
            Response.Redirect("Index.aspx");
        }
    }
}