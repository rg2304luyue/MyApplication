import router from '@ohos.router';

export interface NoteItem {
  id: number;
  title: string;
  content: string;
  date: string;
  color: string; // 便签卡片的背景颜色
}

@Entry
@Component
struct Home {
  // 使用 AppStorage 实现全局数据双向绑定，初始默认给两条模拟便签
  @StorageLink('globalNotes') notesList: NoteItem[] = [
    { id: 1, title: '学习计划', content: '今天完成鸿蒙作业二的高分界面设计！', date: '05-25', color: '#FFF9C4' }, // 经典淡黄
    { id: 2, title: '购物清单', content: '买牛奶、面包、咖啡豆', date: '05-24', color: '#E8F5E9' }  // 淡绿
  ];

  build() {
    // 使用 Stack 容器方便层叠放置右下角的悬浮按钮
    Stack({ alignContent: Alignment.BottomEnd }) {

      Column() {
        // 顶部标题栏
        Row() {
          Text('小米风 · 便签')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1A1A1A')

          Button('注销')
            .fontSize(14)
            .backgroundColor('#FA2A2D')
            .height(30)
            .onClick(() => {
              router.replaceUrl({ url: 'pages/Index' });
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ left: 20, right: 20, top: 40, bottom: 10 })

        // 便签双列网格列表
        Grid() {
          ForEach(this.notesList, (item: NoteItem) => {
            GridItem() {
              Column() {
                Text(item.title)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .margin({ bottom: 8 })

                Text(item.content)
                  .fontSize(14)
                  .fontColor('#555555')
                  .maxLines(4)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
              }
              .alignItems(HorizontalAlign.Start)
              .width('100%')
              .padding(15)
              .backgroundColor(item.color)
              .borderRadius(12)
              .shadow({ radius: 4, color: '#10000000', offsetX: 2, offsetY: 2 })
              .onClick(() => {
                // 点击便签，跳转到详情页，并把当前便签的 ID 传过去
                router.pushUrl({
                  url: 'pages/Detail',
                  params: { noteId: item.id }
                });
              })
            }
          }, (item: NoteItem) => item.id.toString())
        }
        .columnsTemplate('1fr 1fr') // 双列等宽
        .columnsGap(12)
        .rowsGap(12)
        .padding(15)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F7F7F9')

      // 右下角悬浮添加按钮 (FAB)
      Button('+', { type: ButtonType.Circle })
        .width(60)
        .height(60)
        .fontSize(30)
        .backgroundColor('#FF9800') // 小米经典的橙色色系
        .shadow({ radius: 10, color: '#40FF9800', offsetX: 0, offsetY: 5 })
        .margin({ right: 25, bottom: 30 })
        .onClick(() => {
          // 点击新建，传一个 0 代表新便签
          router.pushUrl({
            url: 'pages/Detail',
            params: { noteId: 0 }
          });
        })
    }
    .width('100%')
    .height('100%')
  }
}