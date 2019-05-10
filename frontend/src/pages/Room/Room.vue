<template>
  <div class="live_basic" :style="{height:live_basic_height+'px'}">
    <el-dialog v-el-drag-dialog :visible.sync="innerVisible" title="编辑器" >
      <div class="title">
        <span>请谈谈你对线性代数这门科学的看法</span>
      </div>
      <markdown-editor ref="markdownEditor" v-model="content" :options="{hideModeSwitch:true,previewStyle:'tab'}" height="200px"/>
      <div class="operating">
        <el-button type="primary">提交</el-button>
        <el-button>重置</el-button>
      </div>
    </el-dialog>
    <div class="live_bg"></div>
         <div class="live_show">
    <el-row>
      <el-col  :span="left" >
        <div class="live_play"> 
           <div class="left_header">
        <el-row >
          <el-col :span="3">
            <img
              src="https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif"
              class="user-avatar"
            >
          </el-col>
          <el-col :span="18">

            <el-row>
              <el-col :span="2" style="overflow:hidden;">
                  <el-tag size="mini" type="success" style="margin-top:5px;">直播</el-tag>
              </el-col>
              <el-col :span="8">
                <h1>{{newTitle}}</h1>
              </el-col>
                        <el-col :span="10">
                 <p>{{live.classification}}</p>
              </el-col>
            </el-row>


            <el-row class="live_header_morinfo">
              <el-col :span="4">
                 <div>{{live.teacher}}</div>
              </el-col>
              <el-col :span="3">
                <div class="live_ranking">
                  <svg-icon class-name="search-icon" icon-class="search"/>
                  {{live.ranking}}
                </div>
              </el-col>
              <el-col :span="16">
                <svg-icon class-name="search-icon" icon-class="search"/>
                {{live.number}}
              </el-col>
            </el-row>




          </el-col>
          <el-col :span="3">
            <Button type="primary" class="movie_butten">
              <svg-icon class-name="search-icon" icon-class="search"/>关注
            </Button>
          </el-col>
        </el-row>
           </div>

        <div class="left_main">
          <video controls id="videoElement" :style="{width: leftheight+'px'}"></video>
        </div>
          <div class="left_bottem">

        <el-row >
          <el-col :span="20"></el-col>
          <el-col :span="4">
            <el-button type="primary" @click="innerVisible = true" :disabled="textshow" style="margin-top:20px;">打开编辑器</el-button>
          </el-col>
        </el-row>
          </div>

        </div>
      </el-col>
      <el-col :span="right" style="padding:10px 5px">
        <div class="live_info" v-show="rightshow">

        
        <div class="right_header">
          <h1>教师助理</h1>
                  <img src="./hedda2.png" alt="">
                        <img src="./hdsad3.png" alt="">
                        <img src="./hedda2.png" alt="">
        </div>
        <div class="right_main">
          <div class="live_massge">
            <ul class="live_comments">
              <li v-for="comm in comments" :key="comm">
                <p>
                  <span>{{comm.uname}}:</span>
                  {{comm.utext}}
                </p>
              </li>
            </ul>
          </div>
        </div>
        <div class="live_comm">
                                      <el-row class="comm_buttonBar" >
                                <el-col :span="7" style="color:#1e88e5;font-size:16px;" > 讨论主题:</el-col>
                                <el-col :span="16" style="font-size:16px; text-align:left;">{{commm}}</el-col>                          
                            </el-row>
  
          <el-input
            class="comm_input"
            v-model="user_comment"
            type="textarea"
            :el-rows="3"
            placeholder="在此输入....."
          ></el-input>
        </div>
        <span class="count">剩余讨论时间{{count}} s</span>
        <Button type="primary" class="comm_sent" @click="sendMessage()">发送</Button>
        </div>
      </el-col>
    </el-row>
         </div>
  </div>
</template>
<script>
import flvjs from 'flv.js'
import elDragDialog from '@/directive/drag'
import MarkdownEditor from '@/components/MarkdownEditor'

export default {
  directives: { elDragDialog },
  data () {
    return {
      innerVisible: false,
      live_basic_height: 800,
              left:18,
        right:6,
        leftheight: 878,
        count:'',
        client:'',
      count: '',
      client: '',
      content: '',
      user_comment: '',
      textshow: true,
      innerVisible: false,
             innerVisible: false,
    rightshow: true,
     commm: '三大主流框架对比',
     rightshow:false,
      live: {
        title: '线性代数第一章',
        classification: '高等数学',
        teacher: '李永乐老师',
        ranking: '1000',
        user: '',
        number: 1233
      },
      comments: [],
      radio: '1'
    }
  },
  computed: {
    newTitle:function(){
        // console.log(this.live.title);
        // return this.live.title
        return (this.live.title.length>8) ? this.live.title.substring(0,7)+'...'  : this.live.title;
    }  
  },
  methods: {
      sendMessage: function(){
  
           this.comments.push({uname: '你自己' ,utext: this.user_comment});
         this.client.emit('msg',this.user_comment);
         this.user_comment = '';
         
      },
      submit: function(){
          console.log(this.questions)
          this.$axios.post(`live/${this.$route.params.id}/receipt`,{
              data: this.questions
          }).then(()=>{
                  this.$Message.info('提交成功', 3);
          })
          this.innerVisible = false;
      },
      changesmall: function(type){
          if(type){
              this.rihgtshow = true;
              this.left=18;
              this.right=6;
              this.leftheight=878;
              this.getCode();
              this.live_basic_height = 800
              
          }else{
            //   console.log("ssssss")
              this.rihgtshow = false;
               this.left=24;
              this.right=0;
              this.leftheight=1178;
              this.live_basic_height = 950              
          }
      },
      innershow: function(){
          this.innerVisible=true;
      }, 
      getCode: function(){
          let _this = this;
     const TIME_COUNT = 180;
     if (!this.timer) {
       this.count = TIME_COUNT;
       this.timer = setInterval(() => {
       if (this.count > 0 && this.count <= TIME_COUNT) {
         this.count--;
        } else {
     
         clearInterval(this.timer);
        this.changesmall(false)
        this.$Message.info('讨论结束', 3);
         this.timer = null;
        }
       }, 1000)
      }
   }  
  },
  created() {
    // Vue.use(VueSocketio, '170.20.153.144:3000');
     let _this = this; 
    this.client =  socketio('ws://172.20.153.144:7001',{query:{room:this.$route.params.id,userID:$store.state.userdata.name}});
   this.client.on('connect',function(){
    console.log("sucess");
    // this.$socket.emit('join','甘霖娘')
    });
   
   this.client.on( 'msg', function(uname,utext){
    //    console.log(this.comments);
    // console.log({uname,utext})
        _this.comments.push({uname,utext});
    },);
    this.client.on('online', function(val){
        console.log(val);
        _this.$Message.warning('有学生加入');

    });
this.client.on('startQuiz',(num,time,data)=>{
        console.log('data',data)
         this.questions.splice(0,100);
         this.questions = this.questions.concat(data);
        console.log('arr:',this.questions)
        _this.textshow = false;
    })
    this.client.on('startDiscuss' ,function(sub,time){

        _this.changesmall(true);
        _this.commm = sub;
    })
    this.client.on('pissoff',function(mess){
         _this.$Message.info('直播结束', 10);
         _this.client.disconnect();
    })
  },
  components: {},
//    sockets:{
//     connect: function(){
//     console.log("sucess");
//     // this.$socket.emit('join','甘霖娘')
//     },
//     msg: function(val){
//         console.log(val)
//         this.comments.push(JSON.parse(val));
//     },
//     online: function(val){
            
//     this.$Message.warning('这是一条警告的提示');
//     console.log("online",val);
//         this.comments.push(JSON.parse(val));
//     }

//   },
  mounted(){
    if (flvjs.isSupported()) {
        var videoElement = document.getElementById('videoElement');
        var flvPlayer = flvjs.createPlayer({
            type: 'flv',
            url: `http://118.25.45.164:9090/live/${this.$route.params.id}.flv`
        });
        flvPlayer.attachMediaElement(videoElement);
        flvPlayer.load();
        flvPlayer.play();
    }
  }
}
</script>

<style rel="stylesheet/scss" lang="scss">
.live_basic{
  background-color: #f2f3f5;
  animation:all 5s ease-in;
  color: #495060;
  h1 {
      font-weight: 500;
    font-size: 23px;
    margin:0px;
    padding:0px;
  }
  p{
    margin: 0px;
    padding: 0px;
  }
  }
.live_bg{
   
    background:url('./bg.webp')  0 0 /100% 100% no-repeat;
    position: absolute;
    left: 0;
    right: 0;
    width: 100%;
    height: 800px;
    
}
.live_show{
    width: 1200px;
    margin:  auto;
    padding-top: 15px 0px;
}
.live_play, .live_info{
    height: 700px;
    background: #fff;
    border-radius: 10px;
    border: #e1e1e1 1px solid;
}
.left_header img{
    height: 66px;
    border-radius: 40px;
 
}
.left_header{
        padding: 17px 24px 17px 17px;
            height: 100px;
            .user-avatar{
              width: 66px;
              height: 66px;
            }
}
.left_header h1{
    font-weight: 500;
    font-size: 23px;
   
}

.left_header p{
    line-height: 34px;
}
.left_main{
     animation:all 5s ease-in;
}
.left_bottem{
    height: 100px;
      padding: 17px 24px 17px 17px;
      background-color: #fff;
      border-radius: 0px 0px 10px 10px;
      margin-top:-5px;
}
.live_header_morinfo{
    margin-top: 8px;
    font-size: 16px;
}
.live_header_morinfo i{
    font-size: 18px;
    color: deeppink;
    
}
.right_header{
    height: 120px;
    background-color: #fff;
    border-radius: inherit;
    

}
.right_main{
    background-color: #eee;
   height: 575px;
   border-radius: 0px 0px 10px 10px;
    border-bottom: #e1e1e1 1px solid;
}
.right_header h1{
    font-size: 14px;
    width: 100%;
    text-align: center;
    font-weight: 400;
    color: #888;
    border-bottom: 1px #eee solid;
    margin: 4px 0px;
}
.right_header img{
    width: 80px;
    margin-left: 10px;
    margin-top:5px;
}
.live_massge{
    padding: 5px;
    height: 440px;
    
}
.live_comments li{
    list-style: none;
    padding: 5px 5px; 

}
.live_comments span{

    color: #23ade5;
    font-size: 14px;
    height: 20px;
    font-weight: 500;
}
.live_comments p{
    
    position: relative;
    color: #646c7a;
    line-height: 20px;
    font-size: 14px;
    font-weight: 400;
    white-space: normal;
     word-wrap:break-word;  
    word-break:break-all;  
    overflow: hidden;
   
   
}
.comm_input{
    padding: 5px 18px;
  
    line-height: 18px !important;
}
.comm_sent{
    float: right;
    margin-right: 20px;
    padding: 3px 25px;
}
.comm_buttonBar div{
    color: #646c7a;
    font-size: 14px;
    text-align: right;
    font-weight: 500;
    cursor: pointer;
}
.count{
    margin:20px 0px 0px 20px;
    font-size: 14px;
    color: #23ade5;
}
.sssadasdas{
    margin: 5px 0px 10px 0px ;
}

</style>
