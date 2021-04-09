<template>
  <section class="get-data">
    <div class="get-data__title">
      <h2>Получаемые данные актуальны для валюты {{ whatToSearch }}</h2>
    </div>
    <div class="get-data__block">
      <table>
        <thead>
          <tr>
            <th>Amount</th>
            <th>Price</th>
            <th v-if="windowWidth">Total</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="bid in bids" :key="bid[0]">
            <td>{{ bid[0] }}</td>
            <td>{{ bid[1] }}</td>
            <td v-if="windowWidth">{{ bid[2] }}</td>
          </tr>
        </tbody>
      </table>
    </div>
    <div class="get-data__block">
      <table>
        <thead>
          <tr>
            <th>Amount</th>
            <th>Price</th>
            <th v-if="windowWidth">Total</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="ask in asks" :key="ask[0]">
            <td>{{ ask[0] }}</td>
            <td>{{ ask[1] }}</td>
            <td v-if="windowWidth">{{ ask[2] }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </section>
</template>

<style lang="scss">
.get-data__block {
  table {
    width: 100%;
  }
  
  display: inline-flex;
  height: 25em;
  width: 40%;
  padding: 0 2%;
  overflow: hidden scroll;
}
@media (max-width: 991px) {
  .get-data__block {
    width: 80%;
    padding: 2em 0;
  }
}
@media (max-width: 496px) {
  .get-data__block {
    width: 98%;
    overflow: scroll;
  }
}
</style>

<script>
export default {
  name: "Home",
  data () {
    return {
      windowWidth: true
    }
  },
  computed: {
    bids() {
      return this.$store.state.bids
    },
    asks() {
      return this.$store.state.asks
    },
    symbol() {
      return this.$store.state.whatToSearch
    },
    howMuchToSearch() {
      return this.$store.state.howManyToSearch
    },
    whatToSearch() {
      return this.$store.state.whatToSearch
    }
  },
  methods: {
    getData(arrayName) {
      this.$store.dispatch('get', arrayName)
    },
    resizeEventHandler() {
      if (window.innerWidth >= 496) {
        this.windowWidth = true
      } else {
        this.windowWidth = false
      }
    }
  },
  mounted() {
    window.addEventListener("resize", this.resizeEventHandler);
    setInterval(() => {
      this.getData('bids')
      this.getData('asks')
    }, 1000);
  }
};
</script>
