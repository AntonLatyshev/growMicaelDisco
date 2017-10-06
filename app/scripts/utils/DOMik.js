import closest from 'closest';
// closest(document.body, 'html') === document.documentElement
// closest(document.body, 'body', true) === document.body
// closest(document.documentElement, 'html') == null


const DOMik = {};

const getOffset = DOMik.getOffset = function getOffsetF(el) {
  const box = el.getBoundingClientRect()
  const body = document.body
  const docElem = document.documentElement
  const scrollTop = window.pageYOffset;
  const scrollLeft = window.pageXOffset;
  const clientTop = docElem.clientTop || body.clientTop || 0;
  const clientLeft = docElem.clientLeft || body.clientLeft || 0;
  const top  = box.top +  scrollTop - clientTop;
  const left = box.left + scrollLeft - clientLeft;
  return {
    top: Math.round(top),
    left: Math.round(left)
  }
};
const addListener = DOMik.addListener = function addListenerF(el, ev, cb) {
  if (Array.isArray(el) && Array.isArray(ev) && Array.isArray(cb)) {
    for (let k = 0; k < el.length; k++) {
      for (let i = 0; i < ev.length; i++) {
        for (let j = 0; j < cb.length; j++) {
          el[k].addEventListener(ev[i], cb[j]);
        }
      }
    }
  } else if (Array.isArray(el) && Array.isArray(ev)) {
    for (let i = 0; i < el.length; i++) {
      for (let j = 0; j < ev.length; j++) {
        el[i].addEventListener(ev[i], cb);
      }
    }
  } else if (Array.isArray(ev) && Array.isArray(cb)) {
    for (let i = 0; i < ev.length; i++) {
      for (let j = 0; j < cb.length; j++) {
        el.addEventListener(ev[i], cb[j]);
      }
    }
  } else if (Array.isArray(el) && Array.isArray(cb)) {
    for (let i = 0; i < el.length; i++) {
      for (let j = 0; j < cb.length; j++) {
        el[i].addEventListener(ev, cb[j]);
      }
    }
  } else if (Array.isArray(ev)) {
    for (let i = 0; i < ev.length; i++) {
      el.addEventListener(ev[i], cb);
    }
  } else if (Array.isArray(cb)) {
    for (let i = 0; i < cb.length; i++) {
      el.addEventListener(ev, cb[i]);
    }
  } else if (Array.isArray(el)) {
    for (let i = 0; i < el.length; i++) {
      el[i].addEventListener(ev, cb);
    }
  } else {
    el.addEventListener(ev, cb);
  }
};
const scrollTop = DOMik.scrollTop = (value) => {
  if (typeof value === 'undefined') {
    if (window.pageYOffset) return window.pageYOffset;
    return (document.documentElement && document.documentElement.scrollTop) || document.body.scrollTop;
  } else if (typeof value === 'number') {
    document.documentElement.scrollTop = document.body.scrollTop = value;
    return value;
  } else {
    throw new Error(`value in scrollTop function must be a number, not ${typeof value}`);
  }
}

DOMik.closest = closest;
export default DOMik;
export {
  getOffset,
  addListener,
  closest,
  scrollTop
}
