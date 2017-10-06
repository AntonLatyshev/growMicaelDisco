export default (int) => {
  let res = int.toString();
  res = res.length < 2 ? `0${res}` : res;
  return res;
}
