// SPDX-License-Identifier: MIT
// Copyright (c) 2019 Gennady Trafimenkov
// Copyright (c) https://github.com/blacklabelops-legacy/jenkins/blob/bc22fe9c2549acead4ef84db2b42c96fa5eb1cf7/imagescripts/initplugins.sh

import jenkins.model.*
import java.util.logging.Logger

def pluginParameter="{{ ' '.join(jenkins_plugins_installed_on_boot) }}"

def plugins = pluginParameter.split()

def logger = Logger.getLogger("")

logger.info("installing plugins: " + plugins)

def instance = Jenkins.getInstance()
def pm = instance.getPluginManager()
def uc = instance.getUpdateCenter()

def installed = false
def initialized = false
plugins.each {
  logger.info("Checking " + it)
  if (!pm.getPlugin(it)) {
    logger.info("Looking UpdateCenter for " + it)
    if (!initialized) {
      uc.updateAllSites()
      initialized = true
    }
    def plugin = uc.getPlugin(it)
    if (plugin) {
      logger.info("Installing " + it)
      def installFuture = plugin.deploy()
      while(!installFuture.isDone()) {
        logger.info("Waiting for plugin install: " + it)
        sleep(3000)
      }
      installed = true
    }
  }
}
if (installed) {
  logger.info("Plugins installed, initializing a restart!")
  instance.save()
  instance.restart()
}
