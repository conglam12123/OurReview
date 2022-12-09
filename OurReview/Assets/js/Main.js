var DeletePost = function (id) {
    confirm('Bạn có chắc là muốn xóa bài viết này không ?');
    let args = '<%=DELETE_COMMAND_NAME%>' + ":" + id;
    let context = '<%=DELETE_COMMAND_NAME%>' + ":" + id;
            <%=CallbackRef %>
};

var LikePost = function (id) {
    let args = '';
    listOfPost = document.getElementsByClassName("post");
    for (e of listOfPost) {
        if (e.firstElementChild.value == id) {
            if (e.children[5].children[0].classList.contains("liked")) {
                e.children[5].children[0].classList.remove("liked");
                args = '<%=UNLIKE_COMMAND_NAME%>' + ":" + id;
            }
            else if (!e.children[5].children[0].classList.contains("liked")) {
                e.children[5].children[0].classList.add("liked");
                args = '<%=LIKE_COMMAND_NAME%>' + ":" + id;
            }
        }
    }
    let context = '<%=LIKE_COMMAND_NAME%>' + ":" + id;
    console.log(context, args)
        <% -- <%=CallbackRef %> --%> --%>
        };

var callbackCompleted = function (data, context) {
    alert("context=" + context + " Data =" + data);
    if (data == 0) {
        alert('Xóa thất bại');
    } else {
        alert('Xóa bài viết thành công');
        var listOfPost = [];
        listOfPost = document.getElementsByClassName("post");
        for (e of listOfPost) {
            if (e.firstElementChild.value == context) {
                e.remove();
            }
        }
    }
}