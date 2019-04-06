<template>
  <div class="main">
    <el-row>
      <el-col
        :span="4"
        v-for="(o, index) in roomList"
        :key="index"
        :offset="index % 5 === 0 ? 0 : 1"
      >
        <div @click="enterRoom(o.room_id)">
          <el-card :body-style="{ padding: '0px', height: '20pxs'}" shadow="hover">
            <img src="@/assets/logo.png" class="image">
            <div class="footer">
              <h4>{{o.title}}</h4>
              <p>
                {{o.desc.length > 10 ? `${o.desc.substring(0, 10)}...` : o.desc}}
                <span class="popular">{{o.online}}</span>
              </p>
            </div>
          </el-card>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<style scoped>
.el-col {
  margin-top: 10px;
  margin-bottom: 10px;
}
.main {
  padding: 20px 10px;
}

.image {
  width: 100%;
  height: 100px;
  display: block;
}

.popular {
  position: absolute;
  top: 0;
  right: 10px;
  width: 80px;
  text-align: right;
  vertical-align: middle;
}
.footer {
  height: 50px;
}
.footer p {
  position: relative;
  bottom: 0;
  width: 100%;
  padding: 0 10px 8px;
  font-size: 0;
  line-height: 1.5;
  box-sizing: border-box;
  color: #889;
  font-size: 12px;
}
.footer h4 {
  font-size: 14px;
  text-indent: 10px;
  white-space: nowrap;
  line-height: 1.2;
  width: 100%;
  overflow: hidden;
  text-overflow: ellipsis;
  margin-top: 10px;
  margin-bottom: 6px;
}
h4,
p {
  margin: 3px;
}
</style>

<script>
import { getRoomList } from '@/api/room'

export default {
  name: 'Home',
  data () {
    return {
      currentDate: '今日直播',
      roomList: []
    }
  },
  mounted () {
    this.getRoomList()
  },
  methods: {
    getRoomList () {
      getRoomList().then(res => (this.roomList = res.data))
    },
    enterRoom (roomID) {
      this.$router.push({ path: `/room/${roomID}` })
    }
  }
}
</script>
