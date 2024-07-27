export const getNextIndex = (len: number, now: number) => { // 下一个
  return (now + len + 1) % len
}

export const shuffleArray = (array: number[]): number[] => { // 数组洗牌
  let temp = 0;
  const res = [...array]
  for (let i = res.length - 1; i > 0; i--) {
    // 生成从0到i的随机索引
    const j = Math.floor(Math.random() * (i + 1));
    // 交换元素
    temp = res[i]
    res[i] =  res[j]
    res[j] = temp
  }
  return res;
}