$( document ).ready(function() {

  markers = [];
  mapCreated = 0;

  $('#map-container').hide();

  $('#little-map').on('click', function(){
    console.log('clicked');

    $('#photo-grid').hide()
    $('#map-container').show();
  });

  $('#little-place').on('click', function(){
    $('#map-container').hide()
    $('#photo-grid').show();
  });

  function current_user(){
    $.ajax({
      type: 'GET',
      url: '/users'
    }).done(function(data){
      user = data
    })
  }

  current_user()

  $('button.sign-in').on('click', function(){
    $.ajax({
      type: 'POST',
      url: '/session',
      data: { email: $('input.email').val(), password: $('input.password').val() }
    }).done(function(){
      $($('main').children()[0]).children()[5].remove()
      $($('main').children()[0]).children()[4].remove()
      $($('main').children()[0]).children()[3].remove()
      $($('main').children()[0]).children()[2].remove()
    });
  });

  $('button.search').on('click', function(){
    var location = $('input.location').val();
    $.ajax({
      type: 'GET',
      url: '/session',
      data: { location: location }
    }).done(function(response){
        var main = document.querySelector('main');
        $('main').empty()
        var grid = document.createElement('div');
        grid.setAttribute('id', "photo-grid");
        main.appendChild(grid);
        var ul = document.createElement('ul');
        ul.setAttribute('class', 'small-block-grid-5')
        grid.appendChild(ul);

        for(var i = 0; i < response.length; i++){

          var li = document.createElement('li');
          li.setAttribute('id', i);
          var img = document.createElement('img')
          img.setAttribute('src', response[i]["photo_url"]);
          li.appendChild(img);
          li.addEventListener('click', function(event){
            var container = document.createElement('div');
            container.setAttribute('class', 'container');
            $(grid).toggle();
            var close = document.createElement('button');
            close.setAttribute('class', 'close');
            close.innerText = 'X';
            container.appendChild(close)
            var model = response[event.target.parentElement.id]
            var activity = document.createElement('div')
            activity.setAttribute('class', 'activity')
            var activityImage = document.createElement('img')
            activityImage.setAttribute('src', model.photo_url);
            activity.appendChild(activityImage);
            var title = document.createElement('h3');
            title.innerText = model.name
            activity.appendChild(title);
            if (model.text) {
            var content = document.createElement('p');
            content.innerText = model.text;
            activity.appendChild(content);
            }
            var location = document.createElement('p');
            location.innerText = model.location;
            activity.appendChild(location);
            var category = document.createElement('p');
            category.innerText = 'Category: ' + model.category;
            activity.appendChild(category);
            var url = document.createElement('a');
            url.setAttribute('href', model.url);
            url.innerText = model.url;
            activity.appendChild(url);
            var add = document.createElement('button');
            add.innerText = 'Add to Map';

            add.addEventListener('click', function(){
              $.ajax({
                type: 'POST',
                url: '/activities',
                data: { activity: model }
              }).done(function(data){
                if (mapCreated == 0){
                  console.log(data);
                  var latitude = parseFloat(data.lat);
                  var longitude = parseFloat(data.long);
                  var info = data.photo_url;
                  createMap(latitude, longitude, info);
                  mapCreated = 1;
                } else {
                  console.log("error");
                }
              });
            });
            activity.appendChild(add);
            container.appendChild(activity);
            $('main').append(container);

            close.addEventListener('click', function(){
            $('#photo-grid').toggle()
            $('.container').remove()
          })
          });
          ul.appendChild(li);
      }
    })
  });

});
