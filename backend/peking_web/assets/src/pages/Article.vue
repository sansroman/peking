<template>
  <div id="article">
    <el-row v-for="article in articles" :key="article.index">
      <el-card class="box-card">
        <div class="article-header">
          <h3>{{article.title}}</h3>
        </div>
        <div class="article-body">
          <p>{{article.content}}</p>
        </div>
        <div class="article-footer">
          <p>author: {{article.author.name}} created_at: {{article.created_at}}</p>
        </div>
      </el-card>
    </el-row>
  </div>
</template>
<script>
export default {
  name: 'Article',
  data () {
    return {
      articles: [{
        title: 'this is a article',
        author: {
          name: 'sans',
          role: 'teacher'
        },
        content: `
              When a gardener or farmer plants seeds, he or she distributes the seed over a particular area or multiple areas. Depending on the soil quality, moisture levels, and amount of light an area gets, the seeds can grow into healthy plants, and ultimately food. If conditions aren’t ideal, the seeds won’t flourish. The same basic principles apply to the marketing practice of Content Seeding.
              Content seeding is similar, although in this case the seeds being planted won’t produce plants. They’ll produce interest in your brand, and potentially new customers for your company. And the “soil,” if you will, is often a social media platform.`,
        created_at: '2019-04-04'
      }]
    }
  }
}
</script>
<style lang="scss" scoped>
#article{
  margin: 40px;
}
</style>
