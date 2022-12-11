using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OurReview
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //kiểm tra trạng thái của người dùng để hiện avatar góc bên phải
                checkLoginState();

            }
        }

        private void checkLoginState ()
        {
            if (Session["user_id"] == "")
            {
                if (pnAccount.CssClass.Contains("header__account--user"))
                {
                    pnAccount.CssClass = pnAccount.CssClass.Replace("header__account--user", "header__account--anonymous");
                };
                if (!pnAccount.CssClass.Contains("header__account--anonymous"))
                {
                    pnAccount.CssClass = String.Join(" ", pnAccount
                                            .CssClass
                                            .Split(' ')
                                            .Except(new string[] { "", "header__account--anonymous" })
                                            .Concat(new string[] { "header__account--anonymous" })
                                            .ToArray());
                }
            }
            else
            {
                imgAvatar.ImageUrl = Session["user_avatar"].ToString();
            };
        }

        protected void btnUpdateProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect(ConfigurationManager.AppSettings["changeinforurl"]);
        }
        protected void btnChangePass_Click(object sender, EventArgs e)
        {
            Response.Redirect(ConfigurationManager.AppSettings["changepassurl"]);
        }
        protected void linkProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect(ConfigurationManager.AppSettings["profileuserurl"]);
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect(ConfigurationManager.AppSettings["loginurl"]);        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchtype = "";
            switch (drlSearchOption.SelectedIndex)
            {
                case 0:searchtype= "usersearchurl";break;
                case 1:searchtype = "postsearchurl";break;
            }
            
;            Response.Redirect(ConfigurationManager.AppSettings[searchtype] + "?keyword=" + tbSearch.Text);

        }
    }
}