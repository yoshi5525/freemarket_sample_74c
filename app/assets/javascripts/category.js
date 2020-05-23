$(function(){
  const request = $("#request").attr("action");
  if(request.indexOf("new") != -1 || request.indexOf("new") != 0 || request.indexOf("edit") != -1 || request.indexOf("edit") != 0){
    $.ajax({
      url: "/items/set_parents"
    }).done(function(data){
      $("#category-select").append(`<select class="new-wrapper__main__input-select select-parent" name="item[category_id]" id="item_category_id"><option value="">選択してください</option></select>`);
      data.parents.forEach(function(parent){
        $(".select-parent").append(`<option value="${parent.id}">${parent.name}</option>`);
      })
      $(".select-parent").on("change", function(){
        $(".select-child").remove();
        $(".select-grandchild").remove();
        if($(this).val() == ""){
          $(".select-parent").attr("id"  , "item_category_id");
          $(".select-parent").attr("name", "item[category_id]");
          $(".select-parent").css("margin-bottom", "0");
        }else{
          $.ajax({
            url     : "/items/set_children",
            data    : {parent_id: $(this).val()},
            dataType: "json"
          }).done(function(data){
            $(".select-parent").attr("id"  , "select-parent");
            $(".select-parent").attr("name", "select-parent");
            $(".select-parent").css("margin-bottom", "10px");
            $("#category-select").append(`<select class="new-wrapper__main__input-select select-child" name="item[category_id]" id="item_category_id"><option value="">選択してください</option></select>`);
            data.children.forEach(function(child){
              $(".select-child").append(`<option value="${child.id}">${child.name}</option>`);
            })
          })
        }
      })
      $("#category-select").on("change", ".select-child", function(){
        $(".select-grandchild").remove();
        if($(this).val() == ""){
          $(".select-child").attr("id"  , "item_category_id");
          $(".select-child").attr("name", "item[category_id]");
          $(".select-child").css("margin-bottom", "0");
        }else{
          $.ajax({
            url     : "/items/set_grandchildren",
            data    : {ancestry: `${$(".select-parent").val()}/${$(this).val()}`},
            dataType: "json"
          }).done(function(data){
            $(".select-child").attr("id"  , "select-parent");
            $(".select-child").attr("name", "select-parent");
            $(".select-child").css("margin-bottom", "10px");
            $("#category-select").append(`<select class="new-wrapper__main__input-select select-grandchild" name="item[category_id]" id="item_category_id"><option value="">選択してください</option></select>`);
            data.grandchildren.forEach(function(grandchild){
              $(".select-grandchild").append(`<option value="${grandchild.id}">${grandchild.name}</option>`);
            })
          })
        }
      })
    })
  }
})