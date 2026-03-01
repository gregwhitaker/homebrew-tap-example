package com.example;

public final class HelloBrew {
  public static void main(String[] args) {
    if (args.length == 0) {
      System.out.println("Hello from a Homebrew-installed Java JAR!");
      return;
    }

    System.out.println("Hello, " + String.join(" ", args) + "!");
  }
}
