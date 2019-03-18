
const data = [
  {
    id: '1',
    name: '线性代数',
    timeLine: 50,
    teacher: '李永乐',
    children: [
      {
        id: '1-1',
        chapter: '方程组的几何解释',
        process: '2:12:53'
      },
      {
        id: '1-2',
        chapter: '矩阵消元',
        process: '0:22:31',
        timeLine: 10
      },
      {
        id: '1-3',
        chapter: '乘法和逆矩阵',
        process: '1:14:31',
        timeLine: 10
      },
      {
        id: '1-4',
        chapter: 'A的LU分解',
        process: '0:21:04',
        timeLine: 10
      },
      {
        id: '1-5',
        chapter: '转置-置换-向量空间R',
        process: '1:07:23',
        timeLine: 10
      },
      {
        id: '1-6',
        chapter: '列空间和零空间',
        process: '1:29:4',
        timeLine: 10
      },
      {
        id: '1-7',
        chapter: '求解Ax=0：主变量、特解',
        process: '0:29:33',
        timeLine: 10
      }
    ]

  },
  {
    id: 2,
    name: '离散数学',
    timeLine: 100,
    teacher: '特斯拉'
  }
]

export default data
