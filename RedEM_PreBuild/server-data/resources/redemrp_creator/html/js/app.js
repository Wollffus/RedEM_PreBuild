(function () {
   let MenuTpl =
      '<div id="menu_{{_namespace}}_{{_name}}" class="menu{{#align}} align-{{align}}{{/align}}">' +
      '<div class="head"><span>{{{title}}}</span></div>' +
      '<div class="subtext">{{{subtext}}}</div>' +
      '<div class="topline"></div>' +
      '<div class="menu-items">' +

      '{{#elements}}' +
      '<div class="menu-item {{#selected}}selected{{/selected}}">' +
      '<div id="item-label">{{label}}</div>' +
      '{{#isSlider}}' +
      '<div class="arrows">' +
      '<i class="fas fa-chevron-left"></i>' +
      '<div id="slider-label">{{{sliderLabel}}}</div>' +
      '<i class="fas fa-chevron-right"></i>' +
      '</div>' +
      '{{/isSlider}}' +
      '{{#isCheck}}<div class="check">{{#isActive}}<i class="far fa-check-square"></i> {{/isActive}} {{^isActive}}<i class="far fa-square"></i>{{/isActive}}  </div>{{/isCheck}}' +
      '</div>' +
      '{{/elements}}' +
      '</div>' +
      ' {{#isBigger}}' +
      ' <div class="scrollbottom"></div>' +
      '{{/isBigger}}' +
      ' {{^isBigger}}' +
      '  <div class="noscrollbottom"></div>' +
      ' {{/isBigger}}' +
      '{{#elements}}' +
      '{{#selected}}' +
      '<div class="options-amount">{{{list_id}}} z {{{list_max}}}</div>' +
      '<div class="desciption">{{{desc}}} {{#labelInDesc}} {{{DescriptionLabel}}} {{/labelInDesc}}  </div>' +
      '<div class="topline"></div>' +
      '<div class="subdesciption">{{{subdesc}}} {{#labelInSubDesc}} {{{SubDescriptionLabel}}} {{/labelInSubDesc}}  </div>' +
      '{{/selected}}' +
      '{{/elements}}' +
      '<br>' +
      '</div>' +
      '</div>';

   window.CreatorMenuData = {};
   CreatorMenuData.ResourceName = 'redemrp_creator';
   CreatorMenuData.opened = {};
   CreatorMenuData.focus = [];
   CreatorMenuData.pos = {};

   CreatorMenuData.open = function (namespace, name, data) {
      if (typeof CreatorMenuData.opened[namespace] == 'undefined') {
         CreatorMenuData.opened[namespace] = {};
      }

      if (typeof CreatorMenuData.opened[namespace][name] != 'undefined') {
         CreatorMenuData.close(namespace, name);
      }

      if (typeof CreatorMenuData.pos[namespace] == 'undefined') {
         CreatorMenuData.pos[namespace] = {};
      }

      for (let i = 0; i < data.elements.length; i++) {
         if (typeof data.elements[i].type == 'undefined') {
            data.elements[i].type = 'default';
         }
      }

      data._index = CreatorMenuData.focus.length;
      data._namespace = namespace;
      data._name = name;

      for (let i = 0; i < data.elements.length; i++) {
         data.elements[i]._namespace = namespace;
         data.elements[i]._name = name;
         if (data.elements[i].type == "check") {
            data.elements[i].isActive = false;
            console.log(data.elements[i].type);
         }
      }

      CreatorMenuData.opened[namespace][name] = data;
      CreatorMenuData.pos[namespace][name] = 0;

      for (let i = 0; i < data.elements.length; i++) {
         if (data.elements[i].selected) {
            CreatorMenuData.pos[namespace][name] = i;
         } else {
            data.elements[i].selected = false;
         }
      }

      CreatorMenuData.focus.push({
         namespace: namespace,
         name: name
      });

      CreatorMenuData.render();
      $('#menu_' + namespace + '_' + name).find('.menu-item.selected')[0].scrollIntoView();
   };

   CreatorMenuData.close = function (namespace, name) {
      delete CreatorMenuData.opened[namespace][name];

      for (let i = 0; i < CreatorMenuData.focus.length; i++) {
         if (CreatorMenuData.focus[i].namespace == namespace && CreatorMenuData.focus[i].name == name) {
            CreatorMenuData.focus.splice(i, 1);
            break;
         }
      }

      CreatorMenuData.render();
   };

   CreatorMenuData.render = function () {
      let menuContainer = document.getElementById('menus');
      let focused = CreatorMenuData.getFocused();
      menuContainer.innerHTML = '';
      $(menuContainer).hide();

      for (let namespace in CreatorMenuData.opened) {
         for (let name in CreatorMenuData.opened[namespace]) {
            let creatormenuData = CreatorMenuData.opened[namespace][name];
            let view = JSON.parse(JSON.stringify(creatormenuData));

            for (let i = 0; i < creatormenuData.elements.length; i++) {
               let element = view.elements[i];

               switch (element.type) {
                  case 'default':
                     element.list_id = i + 1;
                     break;

                  case 'slider':

                     element.isSlider = true;
                     element.list_id = i + 1;
                     element.sliderLabel = (typeof element.options == 'undefined') ? element.value : element.options[element.value - 1];
                     element.DescriptionLabel = (typeof element.optionsDescription == 'undefined') ? "" : element.optionsDescription[element.value - 1];
                     element.SubDescriptionLabel = (typeof element.optionsSubDescription == 'undefined') ? "" : element.optionsSubDescription[element.value - 1];
                     element.labelInDesc = (typeof element.optionsDescription == 'object');
                     element.labelInSubDesc = (typeof element.optionsSubDescription == 'object');
                     break;

                  case 'check':
                     element.isCheck = true;
                     element.list_id = i + 1;
                     break;

                  default:
                     element.list_id = i + 1;
                     break;
               }
               element.list_max = creatormenuData.elements.length;
               if (element.list_max > 8) {
                  view.isBigger = true;
               }
               if (i == CreatorMenuData.pos[namespace][name]) {
                  element.selected = true;
               }
            }

            let menu = $(Mustache.render(MenuTpl, view))[0];
            $(menu).hide();
            menuContainer.appendChild(menu);
         }
      }

      if (typeof focused != 'undefined') {
         $('#menu_' + focused.namespace + '_' + focused.name).show();
      }

      $(menuContainer).show();

   };

   CreatorMenuData.submit = function (namespace, name, data) {
      $.post('http://' + CreatorMenuData.ResourceName + '/menu_submit', JSON.stringify({
         _namespace: namespace,
         _name: name,
         current: data,
         elements: CreatorMenuData.opened[namespace][name].elements
      }));
   };

   CreatorMenuData.cancel = function (namespace, name) {
      $.post('http://' + CreatorMenuData.ResourceName + '/menu_cancel', JSON.stringify({
         _namespace: namespace,
         _name: name,
      }));
   };

   CreatorMenuData.change = function (namespace, name, data) {
      $.post('http://' + CreatorMenuData.ResourceName + '/menu_change', JSON.stringify({
         _namespace: namespace,
         _name: name,
         current: data,
         elements: CreatorMenuData.opened[namespace][name].elements
      }));
   };

   CreatorMenuData.getFocused = function () {
      return CreatorMenuData.focus[CreatorMenuData.focus.length - 1];
   };

   window.onData = (data) => {
      switch (data.redemrp_creator_menu_action) {

         case 'openMenu': {
            CreatorMenuData.open(data.redemrp_creator_menu_namespace, data.redemrp_creator_menu_name, data.redemrp_creator_menu_data);
            break;
         }

         case 'closeMenu': {
            CreatorMenuData.close(data.redemrp_creator_menu_namespace, data.redemrp_creator_menu_name);
            break;
         }

         case 'controlPressed': {
            switch (data.redemrp_creator_menu_control) {


               case 'ENTER': {
                  let focused = CreatorMenuData.getFocused();

                  if (typeof focused != 'undefined') {
                     let menu = CreatorMenuData.opened[focused.namespace][focused.name];
                     let pos = CreatorMenuData.pos[focused.namespace][focused.name];
                     let elem = menu.elements[pos];

                     switch (elem.type) {
                        case 'default':
                           if (menu.elements.length > 0) {
                              CreatorMenuData.submit(focused.namespace, focused.name, elem);
                           }
                           break;

                        case 'check': {
                           console.log(elem.isActive);
                           elem.isActive = !elem.isActive;
                           if (menu.elements.length > 0) {
                              CreatorMenuData.submit(focused.namespace, focused.name, elem);
                           }
                           CreatorMenuData.render();
                           break;
                        }

                        default:
                           break;
                     }

                  }

                  break;
               }


               case 'BACKSPACE': {
                  let focused = CreatorMenuData.getFocused();

                  if (typeof focused != 'undefined') {
                     CreatorMenuData.cancel(focused.namespace, focused.name);
                  }

                  break;
               }

               case 'TOP': {
                  let focused = CreatorMenuData.getFocused();

                  if (typeof focused != 'undefined') {
                     let menu = CreatorMenuData.opened[focused.namespace][focused.name];
                     let pos = CreatorMenuData.pos[focused.namespace][focused.name];

                     if (pos > 0) {
                        CreatorMenuData.pos[focused.namespace][focused.name]--;
                     } else {
                        CreatorMenuData.pos[focused.namespace][focused.name] = menu.elements.length - 1;
                     }

                     let elem = menu.elements[CreatorMenuData.pos[focused.namespace][focused.name]];

                     for (let i = 0; i < menu.elements.length; i++) {
                        if (i == CreatorMenuData.pos[focused.namespace][focused.name]) {
                           menu.elements[i].selected = true;
                        } else {
                           menu.elements[i].selected = false;
                        }
                     }

                     CreatorMenuData.change(focused.namespace, focused.name, elem);
                     CreatorMenuData.render();
                     $.post('http://' + CreatorMenuData.ResourceName + '/playsound');

                     $('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected')[0].scrollIntoView();
                  }

                  break;
               }

               case 'DOWN': {
                  let focused = CreatorMenuData.getFocused();

                  if (typeof focused != 'undefined') {
                     let menu = CreatorMenuData.opened[focused.namespace][focused.name];
                     let pos = CreatorMenuData.pos[focused.namespace][focused.name];
                     let length = menu.elements.length;

                     if (pos < length - 1) {
                        CreatorMenuData.pos[focused.namespace][focused.name]++;
                     } else {
                        CreatorMenuData.pos[focused.namespace][focused.name] = 0;
                     }

                     let elem = menu.elements[CreatorMenuData.pos[focused.namespace][focused.name]];

                     for (let i = 0; i < menu.elements.length; i++) {
                        if (i == CreatorMenuData.pos[focused.namespace][focused.name]) {
                           menu.elements[i].selected = true;
                        } else {
                           menu.elements[i].selected = false;
                        }
                     }

                     CreatorMenuData.change(focused.namespace, focused.name, elem);
                     CreatorMenuData.render();
                     $.post('http://' + CreatorMenuData.ResourceName + '/playsound');

                     $('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected')[0].scrollIntoView();
                  }

                  break;
               }

               case 'LEFT': {
                  let focused = CreatorMenuData.getFocused();

                  if (typeof focused != 'undefined') {
                     let menu = CreatorMenuData.opened[focused.namespace][focused.name];
                     let pos = CreatorMenuData.pos[focused.namespace][focused.name];
                     let elem = menu.elements[pos];

                     switch (elem.type) {
                        case 'default':
                           break;

                        case 'slider': {
                           let min = (typeof elem.min == 'undefined') ? 0 : elem.min;
                           if (elem.value > min) {
                              if (typeof elem.hop != 'undefined') {
                                 elem.value = (elem.value - elem.hop);
                                 if (elem.value < min) {
                                    elem.value = min
                                 }
                              } else {
                                 elem.value--;
                              }
                              CreatorMenuData.change(focused.namespace, focused.name, elem);
                           }

                           CreatorMenuData.render();
                           break;
                        }

                        default:
                           break;
                     }

                     $('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected')[0].scrollIntoView();
                  }

                  break;
               }

               case 'RIGHT': {
                  let focused = CreatorMenuData.getFocused();

                  if (typeof focused != 'undefined') {
                     let menu = CreatorMenuData.opened[focused.namespace][focused.name];
                     let pos = CreatorMenuData.pos[focused.namespace][focused.name];
                     let elem = menu.elements[pos];

                     switch (elem.type) {
                        case 'default':
                           break;

                        case 'slider': {
                           if (typeof elem.max != 'undefined' && elem.value < elem.max) {

                              if (typeof elem.hop != 'undefined') {
                                 let min = (typeof elem.min == 'undefined') ? 0 : elem.min;
                                 if (min > 0 && min == elem.value) {
                                    elem.value = 0;
                                 }
                                 elem.value = (elem.value + elem.hop);
                                 if (elem.value > elem.max) {
                                    elem.value = elem.max
                                 }
                              } else {
                                 elem.value++;
                              }
                              CreatorMenuData.change(focused.namespace, focused.name, elem);
                           }

                           CreatorMenuData.render();
                           break;
                        }

                        default:
                           break;
                     }

                     $('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected')[0].scrollIntoView();
                  }

                  break;
               }

               default:
                  break;
            }

            break;
         }
      }
   };

   window.onload = function (e) {
      window.addEventListener('message', (event) => {
         onData(event.data);
      });
   };

})();