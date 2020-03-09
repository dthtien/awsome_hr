import $ from 'jquery';
import 'select2';
import 'select2/dist/css/select2.css';

$(() => {
  const routes = {
    users: '/users/search'
  };

  const elements = {
    managerSelector: '.js-users__form-manager-selector'
  }

  $(elements.managerSelector).select2({
    ajax: {
      url: routes.users,
      dataType: 'json',
      processResults: function (data) {
        console.log(data);
        const results = data.map(item =>({
          id: item.id,
          name: item.name,
          text: item.name
        }));
        console.log('results', results)
        return { results };
      },
      cache: true
    },
    placeholder: 'Search manager username'
  });
});