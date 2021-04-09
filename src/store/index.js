import Vue from "vue";
import Vuex from "vuex";
import { get } from 'axios';
import VueAxios from 'vue-axios'

Vue.use(Vuex);
Vue.use(VueAxios)

export default new Vuex.Store({
  namespaced: true,
  state: {
    bids: [],
    asks: [],
    whatCanSearch: [
      'BTCUSDT',
      'BNBBTC',
      'ETHBTC'
    ],
    whatToSearch: 'BTCUSDT',
    howManyToSearch: 500
  },
  mutations: {
    set(state, data) {
      if (typeof(state[data.to]) === 'string' || typeof(state[data.to]) === 'number') {
        state[data.to] = data.content
      } else if (state[data.to].length >= state.howManyToSearch) {
        state[data.to].splice(0, 1)
        state[data.to].push(data.content)
      } else {
        state[data.to].push(data.content)
      }
    }
  },
  actions: {
    get ({ commit }, arrayName) {
      const url = `https://api.binance.com/api/v3/depth?symbol=${this.state.whatToSearch}&limit=${this.state.howManyToSearch}`

      get(url)
        .then(async (res) => {
          for (const arr of await res.data[arrayName]) {
            commit('set', {
              to: arrayName, 
              content: [arr[0], arr[1], arr[0] * arr[1]]
            })
          }
        })
    }
  },
  modules: {},
});
