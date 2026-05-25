import router from '@ohos.router';
import { NoteItem } from './Home';

@Entry
@Component
struct Detail {
  @StorageLink('globalNotes') notesList: NoteItem[] = [];

  @State noteId: number = 0;
  @State title: string = '';
  @State content: string = '';
  @State curColor: string = '#FFF9C4'; // 默认黄色

  // 可选的便签背景颜色阵列（小米便签平替色）
  private colorOptions: string[] = ['#FFF9C4', '#E8F5E9', '#E3F2FD', '#FCE4EC', '#FFFFFF'];

  aboutToAppear() {
    // 接收从主页传过来的参数
    const params = router.getParams() as Record<string, Object>;
    if (params && params.noteId) {
      this.noteId = params.noteId as number;

      // 如果是修改已有便签，回显数据
      if (this.noteId !== 0) {
        let currentNote = this.notesList.find(item => item.id === this.noteId);
        if (currentNote) {
          this.title = currentNote.title;
          this.content = currentNote.content;
          this.curColor = currentNote.color;
        }
      }
    }
  }

  build() {
    Column() {
      // TopBar 导航栏
      Row() {
        Button('取消')
          .backgroundColor(Color.Transparent)
          .fontColor('#666666')
          .onClick(() => { router.back(); })

        Row({ space: 10 }) {
          // 只有旧便签才显示删除按钮
          if (this.noteId !== 0) {
            Button('删除')
              .backgroundColor('#FA2A2D')
              .height(32)
              .onClick(() => {
                this.notesList = this.notesList.filter(item => item.id !== this.noteId);
                router.back();
              })
          }

          Button('保存')
            .backgroundColor('#FF9800')
            .height(32)
            .onClick(() => {
              if (this.title.trim() === '' && this.content.trim() === '') return;

              if (this.noteId === 0) {
                // 新建便签逻辑
                let newNote: NoteItem = {
                  id: Date.now(), // 用时间戳做简易唯一ID
                  title: this.title === '' ? '无标题' : this.title,
                  content: this.content,
                  date: '05-25',
                  color: this.curColor
                };
                this.notesList.push(newNote);
              } else {
                // 更新现有便签逻辑
                this.notesList = this.notesList.map(item => {
                  if (item.id === this.noteId) {
                    item.title = this.title === '' ? '无标题' : this.title;
                    item.content = this.content;
                    item.color = this.curColor;
                  }
                  return item;
                });
              }
              router.back(); // 保存后返回主页
            })
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 15, right: 15, top: 40, bottom: 10 })

      // 标题输入框
      TextInput({ text: this.title, placeholder: '标题' })
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .backgroundColor(Color.Transparent)
        .onChange((value: string) => { this.title = value; })
        .width('100%')
        .margin({ top: 10 })

      Divider().color('#E0E0E0').strokeWidth(1).margin({ left: 15, right: 15 })

      // 内容多行输入框
      TextArea({ text: this.content, placeholder: '开始记录你的生活...' })
        .fontSize(16)
        .backgroundColor(Color.Transparent)
        .layoutWeight(1)
        .width('100%')
        .onChange((value: string) => { this.content = value; })
        .margin({ top: 10 })

      // 底部换色工具栏
      Row({ space: 15 }) {
        Text('更换背景:').fontSize(14).colorBlend('#888888')
        ForEach(this.colorOptions, (color: string) => {
          Circle()
            .width(30)
            .height(30)
            .fill(color)
            .stroke(this.curColor === color ? '#FF9800' : '#CCCCCC')
            .strokeWidth(this.curColor === color ? 2 : 1)
            .onClick(() => { this.curColor = color; })
        })
      }
      .width('100%')
      .padding(15)
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.curColor) // 整个页面的背景色跟随便签颜色走，沉浸感极强
  }
}