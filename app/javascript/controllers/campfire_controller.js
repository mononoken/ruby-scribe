import { Controller } from "@hotwired/stimulus";
// import anime from "animejs";

// Connects to data-controller="campfire"
export default class extends Controller {
  static targets = ["node1", "node2", "node3", "base", "logs"];

  initialize() {
    // this.element.classList.add(
    //   "box-content",
    //   "w-[300px]",
    //   "h-[300px]",
    //   "relative",
    //   "top-1/2",
    //   "left-1/2",
    //   "transform",
    //   "-translate-x-1/2",
    //   "-translate-y-1/2",
    // );
    // [this.node1Target, this.node2Target, this.node3Target].forEach((node) => {
    //   node.classList.add("w-[100px]", "h-[100px]", "absolute", "bottom-0");
    // });
    // this.logsTarget.classList.add(
    //   "w-3/5",
    //   "h-[100px]",
    //   "absolute",
    //   "bottom-0",
    //   "left-[50px]",
    // );
    // this.node1Target.classList.add("w-[100px]");
    // // this.node2;
    // // this.node3;
    // // this.base;
    // // console.log(this.logsTarget.children);
    // Array.from(this.logsTarget.children).forEach((log) => {
    //   log.classList.add("bg-[#723830]", "w-[20px]", "h-[30px]");
    // });
    // this.animateFlame1();
    // this.animateFlame2();
    // this.animateFlame3();
    // this.animateBaseFire();
  }

  // animateBaseFire() {
  //   anime({
  //     targets: baseFire,
  //     delay: anime.stagger(300),
  //     translateY: function () {
  //       return anime.random(0, -10);
  //     },
  //     keyframes: [
  //       { scale: 0.8 },
  //       { scale: 0.825 },
  //       { scale: 0.9 },
  //       { scale: 0.925 },
  //       { scale: 1 },
  //     ],
  //     duration: 300,
  //     easing: "easeInOutSine",
  //     loop: true,
  //   });
  // }
  //
  // animateFlame1() {
  //   anime({
  //     targets: fireNodes1,
  //     delay: anime.stagger(100),
  //     translateY: function () {
  //       return anime.random(0, 300);
  //     },
  //     rotate: 30,
  //     opacity: function () {
  //       return anime.random(0.5, 1);
  //     },
  //     translateX: function () {
  //       return anime.random(0, -60);
  //     },
  //     scale: 0,
  //     skew: function () {
  //       return anime.random(0, 10);
  //     },
  //     loop: true,
  //     easing: "easeInOutSine",
  //   });
  // }
  //
  // animateFlame2() {
  //   anime({
  //     targets: fireNodes2,
  //     delay: anime.stagger(400),
  //     translateX: function () {
  //       return anime.random(-30, 0);
  //     },
  //     translateY: function () {
  //       return anime.random(0, -260);
  //     },
  //     translateY: function () {
  //       return anime.random(-260, -160);
  //     },
  //     translateX: function () {
  //       return anime.random(0, -30);
  //     },
  //     scale: 0,
  //     rotate: function () {
  //       return anime.random(0, 60);
  //     },
  //     skew: function () {
  //       return anime.random(0, 30);
  //     },
  //     loop: true,
  //     easing: "easeInOutSine",
  //   });
  // }
  //
  // animateFlame3() {
  //   anime({
  //     targets: fireNodes3,
  //     delay: anime.stagger(500),
  //     translateY: function () {
  //       return anime.random(-300, -200);
  //     },
  //     opacity: function () {
  //       return anime.random(0, 1);
  //     },
  //     translateX: function () {
  //       return anime.random(-50, 50);
  //     },
  //     scale: 0,
  //     rotate: function () {
  //       return anime.random(0, -30);
  //     },
  //     skew: function () {
  //       return anime.random(0, 20);
  //     },
  //     loop: true,
  //     easing: "easeInOutSine",
  //   });
  // }
}
