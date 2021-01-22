$(function(){
    $(".nav-controls").append("<div class='add-new-wiki btn btn-new' id='git_wiki_btn'>下载成html</div>");
    $("#git_wiki_btn").click(function(){
        var wiki_title = $(".wiki-page-title").html();
        var wiki_content = $(".wiki").html();
        tpl = tpl.replace(/wikiTitle/ig, wiki_title);
        tpl = tpl.replace(/wikiContent/ig, wiki_content);
        funDownload(tpl, wiki_title+".html");  
    });
})

var funDownload = function (content, filename) {
    // 创建隐藏的可下载链接
    var eleLink = document.createElement('a');
    eleLink.download = filename;
    eleLink.style.display = 'none';
    // 字符内容转变成blob地址
    var blob = new Blob([content]);
    eleLink.href = URL.createObjectURL(blob);
    // 触发点击
    document.body.appendChild(eleLink);
    eleLink.click();
    // 然后移除
    document.body.removeChild(eleLink);
};
