/* ゲームデータ系 */
final int Play_Haba = 400;
final int UI_Height = 160;

final int PlayFieldLeft = width / 2 - Play_Haba / 2;
final int PlayFieldRight = width / 2 + Play_Haba / 2;

final int mojiSize = 24;  //UI文字サイズ指定

/* ショット形状 */
final int SHOT_ORB = 1;  //丸型
final int SHOT_RICE = 2;  //楕円型
final int SHOT_STAR = 3;  //星形
final int SHOT_HENYO = 4;  //へにょりレーザー風（あとに線パーティクルを残す）

/* 合成方法 */
final int BLEND_ALPHA = 1;  //アルファ（通常）
final int BLEND_ADD = 2;  //加算合成
final int BLEND_SUB = 3;  //減算合成

/* アイテムの種類 */
final int ITEM_SCORE = 1;  //スコアアイテム
final int ITEM_LIFE = 2;  //ライフ回復アイテム

/* 敵の状態 */
final int STATUS_ENEMY_ACTIVE = 0;  //稼働時
final int STATUS_ENEMY_SHOOTDOWN = 1;  //撃ち落された瞬間（finalize実行タイミング/finalize処理内で2に書き換える）
final int STATUS_ENEMY_DISACTIVE = 2;  //撃ち落されてから、自分の弾幕が全部消えるまでの間（削除待ち、敵機はゲームに干渉できない）

/* ゲームの状態 */
final int STATUS_GAME_TITLE = 0;  //タイトル画面
final int STATUS_GAME_PLAYING = 1;  //ゲーム画面
final int STATUS_GAME_GAMEOVER = 2;  //ゲームオーバー画面
final int STATUS_GAME_CLEAR = 3;  //クリア画面

/* 自機の選択 */
final int JIKISELECT_STANDARD = 0;
final int JIKISELECT_RAY = 1;
final int JIKISELECT_HOMING = 2;
final int JIKISELECT_FIRE = 3;

/* アイテムタイプ */
final int TYPE_ITEM_POINT = 0;
final int TYPE_ITEM_LIFE = 1;
final int TYPE_ITEM_BOMB = 2;
