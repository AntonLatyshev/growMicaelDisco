import {
  markupMenu
} from './markup-menu';
markupMenu(window.document);
import header from "./header";
import basketPopup from "./basket-popup";
import customScroll from "./customScroll";
import carousel from "./carousel";
import tab from "./tab";
import fancybox from "./fancybox";
import socialLike from "./social-like";
import article from "./article";
import anchorLink from "./anchorLink";
import map from "./map";
import faq from "./faq";
import video from "./video";
import customSelect from "./customSelect";
import valuation from "./valuation";
import rate from "./rate";
import popup from "./popup";
import validation from "./validation";
import filter from "./filter";
// import parsePage from "./parsePage";
if ($('#basket').length) {
  cart();
}
$(() => {
  svg4everybody();
  header();
  basketPopup();
  customScroll('.popup-basket .popup-basket__body');
  customScroll('.about-block__section');
  carousel();
  fancybox('.about-block__video');
  fancybox('.article__video');
  socialLike();
  article();
  anchorLink();
  map();
  faq();
  video();
  customSelect();
  valuation();
  rate();
  popup();
  validation();
  filter();
  tab();
  // parsePage();
  setTimeout(function() {
    $('.tab__content.block').find('.tab-catalog__img').addClass('animate');
  }, 300);
});
