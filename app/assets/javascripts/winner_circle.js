  $(document).ready(function(){
    $('#pick_winners').click(function(){
      for (i = 0; i < $('.redraw_error').length; i++) {
        if ($('.redraw_error')[i].innerHTML != "") {
          $('.redraw_error')[i].innerHTML = "";
        }
      }

      $.ajax ({
        url: "show_winners/",
        dataType: 'JSON',
        success: function(data){
          for (i = 1; i <= (Object.entries(data.winners).length); i++) {
            if (data.winners[i] != "No entry") {
              $('[id$="_' + (i) + '"] > #winner_list').append('<li class="badge_info">Badge: ' + data.winners[i]["badge"] + '</li><li class="name_info">Name: ' + data.winners[i]["name"] + '</li><li class="phone_info">Phone: ' + data.winners[i]["phone"] + '</li><li class="email_info">Email: ' + data.winners[i]["email"] + '</li><li class="pref_info">Preference: ' + data.winners[i]["pref"] + '</li><li class="rating">Rating: ' + data.winners[i]["rating"] + '</li>');
              if (data.winners[i]["proxy"] == true) {
                $('[id$="_' + i + '"] > #proxy_list').append('<li class="p_badge">Badge: ' + data.winners[i]["p_badge"] + '</li><li class="p_name">Name: ' + data.winners[i]["p_name"] + '</li><li class="p_phone">Phone: ' + data.winners[i]["p_phone"] + '</li><li class="p_email">Email: ' + data.winners[i]["p_email"] + '</li><li class="p_pref">Preference: ' + data.winners[i]["p_pref"] + '</li>');
              }
            } else {
              $('[id$="_' + (i) + '"] > #winner_list').append('<li>No entries logged for this title.</li>');
            };

            $('#submit_' + i).attr('id', 'badge_' + data.winners[i]["badge"]);
          }
          $('#pick_winners').attr('style', 'visibility:hidden;');
        }
      });
    });

    $('.redraw').click(function(){
      var title_id = this.closest('button').name.split('_')[1];
      if ((this.closest('button').id.split('_')[0]) == "submit"){
        $('.redraw_error')[title_id - 1].innerHTML = "Please press the 'Pick the Winners' button first.";
      }
      else {
      var badge_id = this.closest('button').id.split('_')[1];

      $.ajax ({
        url: "redraw/",
        data: { badge_id: badge_id, title_id: title_id },
        dataType: 'JSON',
        success: function(data){
          if (Object.keys(data) == "error"){
            console.log(data);
            $('.redraw_error')[title_id - 1].innerHTML = data.error;
          } else {
            console.log($('#badge_' + badge_id));

            $('#badge_' + badge_id).attr('id', 'badge_' + data.new_winner["badge"]);

            $('[id$="_' + data.new_winner["inventory_id"] + '"] > #winner_list > li.badge_info')[0].innerHTML = "Badge: " + data.new_winner["badge"];
            $('[id$="_' + data.new_winner["inventory_id"] + '"] > #winner_list > li.name_info')[0].innerHTML = "Name: " + data.new_winner["name"];
            $('[id$="_' + data.new_winner["inventory_id"] + '"] > #winner_list > li.phone_info')[0].innerHTML = "Phone: " + data.new_winner["phone"];
            $('[id$="_' + data.new_winner["inventory_id"] + '"] > #winner_list > li.email_info')[0].innerHTML = "Email: " + data.new_winner["email"];
            $('[id$="_' + data.new_winner["inventory_id"] + '"] > #winner_list > li.pref_info')[0].innerHTML = "Preference: " + data.new_winner["pref"];
            $('[id$="_' + data.new_winner["inventory_id"] + '"] > #winner_list > li.rating')[0].innerHTML = "Rating: " + data.new_winner["rating"];

            if (data.new_winner["proxy"] == true) {
              $('[id$="_' + data.new_winner["inventory_id"] + '"] > #proxy_list > li.p_badge')[0].innerHTML = "Badge: " + data.new_winner["p_badge"];
              $('[id$="_' + data.new_winner["inventory_id"] + '"] > #proxy_list > li.p_name')[0].innerHTML = "Name: " + data.new_winner["p_name"];
              $('[id$="_' + data.new_winner["inventory_id"] + '"] > #proxy_list > li.p_phone')[0].innerHTML = "Phone: " + data.new_winner["p_phone"];
              $('[id$="_' + data.new_winner["inventory_id"] + '"] > #proxy_list > li.p_email')[0].innerHTML = "Email: " + data.new_winner["p_email"];
              $('[id$="_' + data.new_winner["inventory_id"] + '"] > #proxy_list > li.p_pref')[0].innerHTML = "Preference: " + data.new_winner["p_pref"];
            } else {
              $('[id$="_' + data.new_winner["inventory_id"] + '"] > #proxy_list').empty();
            }
            }
          }
      });
      }
    });
  });