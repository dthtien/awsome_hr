import $ from 'jquery';
import { userSelectors } from './utils';

class UserIndex {
  constructor() {
    this.elements = {
      normalInput: '.js-users_normal-input',
      comparingInput: '.js-users__comparing-user',
      typesSelector: '.js-users__types-selector',
      singleSelect: '.js-users__single-select',
      usersSelector: '.js-users__users-selector'
    }
  }

  initializeActions(){
    userSelectors.config();
    this._handleTypeSelectorChange();
  }

  _handleTypeSelectorChange() {
    const findEmployees = '0';
    const findManager = '1';
    const relationShip = '2';

    $(this.elements.typesSelector).change(e => {
      const value = e.target.value;
      const hiddenClass = 'is-hidden';
      const singleSelectTag = this.elements.singleSelect + ' ' + this.elements.usersSelector;
      const comparingTag = this.elements.comparingInput + ' ' + this.elements.usersSelector;
      const normalInputTag = this.elements.normalInput + ' input';

      switch(value) {
        case findEmployees:
        case findManager:
          $(this.elements.singleSelect).removeClass(hiddenClass);
          $(singleSelectTag).attr('required', true)
          $(this.elements.comparingInput).addClass(hiddenClass);
          $(comparingTag).attr('required', false)
          $(this.elements.normalInput).addClass(hiddenClass);
          $(normalInputTag).attr('required', false);
          break;
        case relationShip:
          $(this.elements.singleSelect).addClass(hiddenClass);
          $(singleSelectTag).attr('required', false)
          $(this.elements.comparingInput).removeClass(hiddenClass);
          $(comparingTag).attr('required', true)
          $(this.elements.normalInput).addClass(hiddenClass);
          $(normalInputTag).attr('required', false);
          break;
        default:
          $(this.elements.singleSelect).addClass(hiddenClass);
          $(singleSelectTag).attr('required', false)
          $(this.elements.comparingInput).addClass(hiddenClass);
          $(comparingTag).attr('required', false)
          $(this.elements.normalInput).removeClass(hiddenClass);
          $(normalInputTag).attr('required', true);
      }
    });
  }
}

$(() => {
  const index = new UserIndex();

  index.initializeActions();
});