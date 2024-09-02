# Changelog

## [2.6.0](https://github.com/luoyi58624/luoyi_flutter_base/compare/v2.5.0...v2.6.0) (2024-08-14)


### Features

* flutter_element_ui代码已全部迁移 ([98135ba](https://github.com/luoyi58624/luoyi_flutter_base/commit/98135baeb9247d569723cc7eb6d79c6dd606e679))
* FontUtil新增字重 ([708045f](https://github.com/luoyi58624/luoyi_flutter_base/commit/708045f23e4408febec6d496544e73e7683f7f9e))
* int扩展函数新增ms ([e3dd10c](https://github.com/luoyi58624/luoyi_flutter_base/commit/e3dd10c337a0f33ba5a22a6af2aae2ecbe55285a))
* 使用 shared_preferences 替代 localstorage ([4682f68](https://github.com/luoyi58624/luoyi_flutter_base/commit/4682f683813995811840cf30685f4617ff2e74bb))
* 迁移 flutter_element_ui 部分代码 ([f52ae51](https://github.com/luoyi58624/luoyi_flutter_base/commit/f52ae519d5f6fdf834a3c01d67cbc9de485b7ad2))
* 迁移font工具类 ([16525ea](https://github.com/luoyi58624/luoyi_flutter_base/commit/16525eaefcd35f2cbd613fef1ad6df37793cb0c7))


### Bug Fixes

* 修复PlatformUtil在web上的判断 ([b7ce1fc](https://github.com/luoyi58624/luoyi_flutter_base/commit/b7ce1fcfec7dd71300ab7b628c33a25dca53f066))
* 修复web上检测IOS平台逻辑判断 ([fda4ce4](https://github.com/luoyi58624/luoyi_flutter_base/commit/fda4ce4bd16fbad274ef44d98b30b05f94c43d6b))
* 修复缺失的导出 ([b655945](https://github.com/luoyi58624/luoyi_flutter_base/commit/b65594579ac47bd3be98619472d5e03536506f80))
* 修复缺失的导出 ([2d05221](https://github.com/luoyi58624/luoyi_flutter_base/commit/2d05221f89d0b3186705b13ccf07bc4889e3f7ca))


### Chores

* 修改font预设字重 ([95da3f1](https://github.com/luoyi58624/luoyi_flutter_base/commit/95da3f1092dafe2bbce8b472885386c751f256ca))
* 更新响应式扩展名称 ([8d1684b](https://github.com/luoyi58624/luoyi_flutter_base/commit/8d1684b26c90a720d2c5afd6113f6d14e8133d3a))

## [2.5.0](https://github.com/luoyi58624/luoyi_flutter_base/compare/v2.4.1...v2.5.0) (2024-07-12)


### Features

* 新增noRipper ([99e7b3a](https://github.com/luoyi58624/luoyi_flutter_base/commit/99e7b3a225a4d2e168d9081c0c36cf8a14daaa78))

## [2.4.1](https://github.com/luoyi58624/luoyi_flutter_base/compare/v2.4.0...v2.4.1) (2024-07-12)


### Chores

* 新增release-please-config.json、.release-please-manifest.json ([075bbc5](https://github.com/luoyi58624/luoyi_flutter_base/commit/075bbc53a23ab7cd0a1ca8371357afb21d5e2de6))
* 移除序列化模型 ([2fba968](https://github.com/luoyi58624/luoyi_flutter_base/commit/2fba968a801cd3342cdf18e3ed395cb356bddc55))

## [2.4.0](https://github.com/luoyi58624/luoyi_flutter_base/compare/v2.3.0...v2.4.0) (2024-07-11)


### Features

* 移除导出的第三方库 ([47b476c](https://github.com/luoyi58624/luoyi_flutter_base/commit/47b476cbf2cc08dd1fa09781057b4eb755427636))

## [2.3.0](https://github.com/luoyi58624/luoyi_flutter_base/compare/v2.2.0...v2.3.0) (2024-07-09)


### Features

* color扩展onHover、onTap第二个参数变更为Color类型，增强灵活性 ([53b65f8](https://github.com/luoyi58624/luoyi_flutter_base/commit/53b65f8f0206e0a1e51ea298f2b2b9735c6fff68))
* 完善ElTapBuilder的delay效果 ([be9e86f](https://github.com/luoyi58624/luoyi_flutter_base/commit/be9e86fc1eb203f03cc9dc150a3908f5addf6e73))
* 移除字体全局配置 ([da741ce](https://github.com/luoyi58624/luoyi_flutter_base/commit/da741ce04ac35d5cfcbdec5ec70c32071f0b2c07))


### Bug Fixes

* ElTapBuilder更新状态防止dispose ([5a9491e](https://github.com/luoyi58624/luoyi_flutter_base/commit/5a9491e3021158cd3c8a4f7ecf25c8cb67198559))

## [2.2.0](https://github.com/luoyi58624/luoyi_flutter_base/compare/v2.1.0...v2.2.0) (2024-06-13)


### Features

* ElHoverBuilder、ElTapBuilder新增InheritedWidget，新增PlatformUtil ([adb4d39](https://github.com/luoyi58624/luoyi_flutter_base/commit/adb4d3958c7a7d08fa14aad863cd5ef8fa076142))
* 优化rootContext的断言 ([7c10a62](https://github.com/luoyi58624/luoyi_flutter_base/commit/7c10a629bd1ea347b96890d97cdd8c8287953170))
* 加载多个字重字体使用并行加载 ([a93a112](https://github.com/luoyi58624/luoyi_flutter_base/commit/a93a1126bec3ae3e456165357ffcecd212427108))
* 完善各种字体排版小部件 ([35a68f4](https://github.com/luoyi58624/luoyi_flutter_base/commit/35a68f4faf87ceef18e8e5af3aa4b8beeb2d89d3))
* 导出go_router并隐藏GoRouterHelper ([dcdd0f3](https://github.com/luoyi58624/luoyi_flutter_base/commit/dcdd0f379b3b6757ea3e06e3bfed1e6615bbbe3b))
* 导出platform ([fe1fa47](https://github.com/luoyi58624/luoyi_flutter_base/commit/fe1fa47eb5dad8f57f9645feab82eed15ba0b3bf))
* 新增config、theme、responsive等基础api ([2ae82b7](https://github.com/luoyi58624/luoyi_flutter_base/commit/2ae82b712a85d258403118ae52f8284f276dc891))
* 新增DividerWidget ([8494a0c](https://github.com/luoyi58624/luoyi_flutter_base/commit/8494a0cd6a9c6a501758478f35047ed842b51fdd))
* 新增DragScrollbarDisabledHover ([a7e62a6](https://github.com/luoyi58624/luoyi_flutter_base/commit/a7e62a667697881fb2cc2c3d95b21be167be6095))
* 新增Font工具类 ([951bfd3](https://github.com/luoyi58624/luoyi_flutter_base/commit/951bfd3396aecc55123afd11dfef13aa38ffe568))
* 新增NoDefaultScrollbarWidget ([1e683a7](https://github.com/luoyi58624/luoyi_flutter_base/commit/1e683a7391e36ead9b3ced59323983173a174044))
* 新增NoScrollBehavior ([d0cb80e](https://github.com/luoyi58624/luoyi_flutter_base/commit/d0cb80e10667063ae93257c51b9cb07de5ec3c81))
* 新增Typography字体排版类 ([41345ec](https://github.com/luoyi58624/luoyi_flutter_base/commit/41345ec90ac026cc1b0520821d5cda848ab4c78f))
* 移除part，使用export导出依赖 ([a58c182](https://github.com/luoyi58624/luoyi_flutter_base/commit/a58c18259b728c487a208ab3bfc58199327e04af))


### Bug Fixes

* onHover、onTap移除BuildContext参数 ([0aa910f](https://github.com/luoyi58624/luoyi_flutter_base/commit/0aa910fa00ecc610cdd16d87d84b45f01e7e8b48))
* 修复未导出的依赖 ([e87b1b8](https://github.com/luoyi58624/luoyi_flutter_base/commit/e87b1b82d77b8e2ac8bd4216fc22986c0a03a2ad))
* 移除HoverBuild、ElTapBuilder ([fbe1940](https://github.com/luoyi58624/luoyi_flutter_base/commit/fbe19405311a8a046d9f324d234599f96c78fbc0))

## [2.1.0](https://github.com/luoyi58624/luoyi_flutter_base/compare/v2.0.1...v2.1.0) (2024-05-22)


### Features

* 新增BrightnessWidget ([86fe920](https://github.com/luoyi58624/luoyi_flutter_base/commit/86fe920a5e28d0e5b99e3abbddad99b688864fe2))

## [2.0.1](https://github.com/luoyi58624/luoyi_flutter_base/compare/v2.0.0...v2.0.1) (2024-05-22)


### Bug Fixes

* 公开ExpireLocalDataModel ([bd6d679](https://github.com/luoyi58624/luoyi_flutter_base/commit/bd6d679be6bea06b6fd14d91dd5495e9ea6f816b))

## [2.0.0](https://github.com/luoyi58624/luoyi_flutter_base/compare/v1.4.0...v2.0.0) (2024-05-22)


### ⚠ BREAKING CHANGES

* 发布2.0.0

### Features

* buildThemeData不接收context,直接传递配置数据即可 ([944a9bf](https://github.com/luoyi58624/luoyi_flutter_base/commit/944a9bf8e4cb335b0d935e739798d2adea0d7e9a))
* 优化drawer主题样式 ([1ff96da](https://github.com/luoyi58624/luoyi_flutter_base/commit/1ff96dae07cbcb69fe1fa767a44c31c968e9e5e9))
* 修复延迟关闭loading的bug ([ee1e5cb](https://github.com/luoyi58624/luoyi_flutter_base/commit/ee1e5cbcecababf65f38469bfe79971c083cbf6b))
* 关闭loading新增提示，优化material3提示样式 ([8a1f722](https://github.com/luoyi58624/luoyi_flutter_base/commit/8a1f722f0b2ee4a16e735b166c6656bc2e157ad0))
* 删除大量公共性不强的代码 ([cbab4ea](https://github.com/luoyi58624/luoyi_flutter_base/commit/cbab4ea9a495eacddab575d8b78357744bbd0bc3))
* 发布2.0.0 ([2dbe399](https://github.com/luoyi58624/luoyi_flutter_base/commit/2dbe399864b19a5962ea86d5d67e720e056b68a1))
* 导出flutter_localizations ([4d5ac6b](https://github.com/luoyi58624/luoyi_flutter_base/commit/4d5ac6bcee7733eaa531dae4a2c0aa8098a59af1))
* 将flutter_font迁移进来，降低维护压力 ([84a9f96](https://github.com/luoyi58624/luoyi_flutter_base/commit/84a9f9692725fb215152370553288fe910773ecf))
* 整理主题代码，将亮色主题、暗色主题颜色合并至config，移除m2、m3配置项 ([67617e6](https://github.com/luoyi58624/luoyi_flutter_base/commit/67617e62a3cf594785bd73c7e6b9ff0e2cb607dc))
* 新增session_storage ([bd28467](https://github.com/luoyi58624/luoyi_flutter_base/commit/bd284673ef82c5081efbeba287e4d23caedff59e))


### Bug Fixes

* 新增私有的_rootNavigatorKey配置 ([600e5e4](https://github.com/luoyi58624/luoyi_flutter_base/commit/600e5e4a2cc66903df8ba05f7146f4e72d547909))

## [1.4.0](https://github.com/luoyi58624/luoyi_flutter_base/compare/v1.3.0...v1.4.0) (2024-05-15)


### Features

* useLocalObs支持自动序列化model、map数据类型 ([3caa90a](https://github.com/luoyi58624/luoyi_flutter_base/commit/3caa90a2e3bd625a0bf6ad2e9fc7d43e664c61bc))
* 修复http缓存拦截器 ([2333b05](https://github.com/luoyi58624/luoyi_flutter_base/commit/2333b050852057a70789996c767c95f11f1f9dce))
* 抽离Map扩展函数至dart_base库 ([a7bfc80](https://github.com/luoyi58624/luoyi_flutter_base/commit/a7bfc80ca9e47153c3658243ae27bb53f5e76b28))
* 新增http、loading等工具类 ([b62940e](https://github.com/luoyi58624/luoyi_flutter_base/commit/b62940ee780a2ad612e4dd4af6e4a1e92f1b1e63))
* 新增toast ([f94c7d2](https://github.com/luoyi58624/luoyi_flutter_base/commit/f94c7d21f3814d2e519a862a2d86a78894eb090e))
* 新增响应式本地变量 ([581984c](https://github.com/luoyi58624/luoyi_flutter_base/commit/581984c197a1f498ee5e22ccaec6a6c1079c19b3))
* 默认导出一些第三方实用包 ([9f923da](https://github.com/luoyi58624/luoyi_flutter_base/commit/9f923daf1f68db0d60d3d0c324ca50c943011a92))

## [1.3.0](https://github.com/luoyi58624/luoyi_flutter_base/compare/v1.2.0...v1.3.0) (2024-05-13)


### Features

* 优化主题，新增ThemeDataUtil ([3346d2b](https://github.com/luoyi58624/luoyi_flutter_base/commit/3346d2bc4cdcab84da7a073ed10c4d5ddcc392f6))
* 新增国际化示例 ([831fdbe](https://github.com/luoyi58624/luoyi_flutter_base/commit/831fdbef927ea42c49b05dd2a29d7b5f0c837f4a))
* 新增更多主题配置 ([cc8a08f](https://github.com/luoyi58624/luoyi_flutter_base/commit/cc8a08f4910a073a5bab04ffbcbe5648cd2b0320))
* 新增离线字体文件，优化windows、web上的字体渲染效果 ([73f5f79](https://github.com/luoyi58624/luoyi_flutter_base/commit/73f5f7930e900ee30bd05917f091c750bf3a3f86))
* 更新 color hsp 算法 ([7db9452](https://github.com/luoyi58624/luoyi_flutter_base/commit/7db945236790daed98ec92a99ccf908f16ec004b))
* 更新文档 ([a5a5c7f](https://github.com/luoyi58624/luoyi_flutter_base/commit/a5a5c7fe92ff6159f9f0e03dbf46374d8d910fc0))
* 移除bgColor2、bgColor3等次级颜色，添加bgColors、headerColors、textColors、iconColors等次级颜色 ([e873712](https://github.com/luoyi58624/luoyi_flutter_base/commit/e87371276b0cb27353bb55d4261809ce19b322e5))
* 移除ThemeDataUtil，更改为已扩展函数形式加载 ([3344fd7](https://github.com/luoyi58624/luoyi_flutter_base/commit/3344fd7c38c0235654964337d8ba6e22ad52c5d9))

## [1.2.0](https://github.com/luoyi58624/luoyi_flutter_base/compare/v1.1.0...v1.2.0) (2024-05-06)


### Features

* color add getLightnessColor ([b05b1c2](https://github.com/luoyi58624/luoyi_flutter_base/commit/b05b1c207d4fb77b24715ae2a7b5d128d2d3b58f))
* AppConfigData defaultFontWeight -&gt; fontWeight ([34b41d3](https://github.com/luoyi58624/luoyi_flutter_base/commit/34b41d3b66fd7accfc5dbcff9acc07acb2971b4c))

## [1.1.0](https://github.com/luoyi58624/luoyi_flutter_base/compare/v1.0.2...v1.1.0) (2024-05-06)


### Features

* globalConfig -&gt; flutterConfig, currentTheme -> flutterTheme ([7ef52f8](https://github.com/luoyi58624/luoyi_flutter_base/commit/7ef52f8b3adeff4966a4a5b619efa46cc01404a5))
* 添加导航模型 ([6cc2d8f](https://github.com/luoyi58624/luoyi_flutter_base/commit/6cc2d8fe0bea1c4d720a70eeaa4cf84bd3d16eb9))


### Bug Fixes

* AppConfigData flutterConfig -&gt; config ([8594ecb](https://github.com/luoyi58624/luoyi_flutter_base/commit/8594ecb4fe1744a53e7e8d83586e7d9c9d169d0a))
* MyCupertinoListTile错别字修复 ([cbe7da5](https://github.com/luoyi58624/luoyi_flutter_base/commit/cbe7da56c7f1212e9ed5fe5ffbc372d77cda5d62))

## [1.0.2](https://github.com/luoyi58624/luoyi_flutter_base/compare/v1.0.1...v1.0.2) (2024-05-04)


### Bug Fixes

* 尝试修复github actions自动化发布脚本 ([6c7869a](https://github.com/luoyi58624/luoyi_flutter_base/commit/6c7869a617f330e606ac34163acc2db3ad9ce8f7))

## [1.0.1](https://github.com/luoyi58624/luoyi_flutter_base/compare/v1.0.0...v1.0.1) (2024-05-04)


### Bug Fixes

* 移除Icon序列化，因为它会要求应用程序必须放弃tree-icon ([7d30973](https://github.com/luoyi58624/luoyi_flutter_base/commit/7d30973f63d5800c37d875bfcb82c38105ff4795))

## 1.0.0 (2024-04-30)


### Features

* 初始化 ([a60e808](https://github.com/luoyi58624/luoyi_flutter_base/commit/a60e80855e11145806bd2ec59b9a372efdc4c364))

## 0.0.1

* TODO: Describe initial release.
