const permission = {
  state: {
    routers: [],
    addRouters: [],
  },
  mutations: {
    SET_ROUTERS: (state, routers) => {
      state.addRouters = routers
    },
  },
  actions: {
    GenerateRoutes() {
      return new Promise(resolve => {
        resolve()
      })
    },
  },
}
export default permission
