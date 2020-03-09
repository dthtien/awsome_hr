import $ from 'jquery';
import 'select2';
import 'select2/dist/css/select2.css';

class UserSelectors {
  constructor(){
    this.routes = {
      users: '/users/search'
    };

    this.elements = {
      managerSelector: '.js-users__users-selector'
    }
  }

  config() {
    $(this.elements.managerSelector).select2({
      width: 'resolve',
      ajax: {
        url: this.routes.users,
        dataType: 'json',
        processResults: function (data) {
          const results = data.map(item =>({
            id: item.id,
            name: item.name,
            text: item.name
          }));
          return { results };
        },
        cache: true
      },
      placeholder: 'Search username'
    });
  }
}

export const userSelectors = new UserSelectors();