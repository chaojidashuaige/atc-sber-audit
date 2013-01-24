$(function() {
});

var $template;
var $previousData;
var $storedAnswers;
var $previousAnswers;

var mvsAreaFlag;
var employeeTbSubbranch;
var taskId;
var vizitType;
var targetPercent;
var previousValue;
var $reduceIndexes;
var $activities;

var answersChanged;

/******************************************************************************
 * Description: 
 * Return: 		
 *****************************************************************************/
function LoadCL(templateXml, previousDataXml, readOnly) {
	if ((templateXml === 0) || (templateXml.length == 0)) {
		return;
	}
	QA = $($.parseXML(templateXml));
	
	$("#checklistForm\\:checklistBody").html(
		$.createHtmlElement("root").append(
			$.createHtmlElement("div").addClass("rightPanel").append(
				$.createHtmlElement("div").addClass("rightPanelFull").append(
					$.createHtmlElement("div").addClass("ResultsPanel").append(
						$.createHtmlElement("table").attr("id", "metricTable")
					)
				).append(
					$.createHtmlElement("div").attr("id", "rightPanel").addClass("rightPanelContent")
				)
			)
		).append(
			$.createHtmlElement("div").attr("id", "leftPanel").addClass("leftPanel")
		).append(
			$.createHtmlElement("div").css({ "clear" : "both", "height" : "1px" }).html("&#160;")
		).html()
	);
	
	var $leftPanel = $("#leftPanel");
	var $rightPanel = $("#rightPanel");
	
	var previousDataXmlDoc = $($.parseXML(previousDataXml));
	$previousData = $(previousDataXmlDoc).children("initialData");
	$storedAnswers = $previousData.children("storedAnswers").children("answer");
	$previousAnswers = $previousData.children("previousAnswers").children("answer");

	$template = $(QA).children("checklistTemplate");
	
	mvsAreaFlag = $previousData.attr("mvsAreaFlag");
	employeeTbSubbranch = $previousData.attr("employeeTbSubbranch");
	taskId = $previousData.attr("taskId");
	vizitType = $previousData.attr("visitType");
	targetPercent = $previousData.attr("targetPercent");
	previousValue = $previousData.attr("previousValue");
	$reduceIndexes = $previousData.find("reduceIndex");
	$activities = $previousData.children("activities").children("activity");
	answersChanged = false;
	
	if ((vizitType == "VT_SELF") || (vizitType == "VT_AUDIT") || (vizitType == "VT_GEMBA")) {
		var $inspectionFormats = $previousData.children("inspectionFormats").children("inspectionFormat").filter(function(index) {
			return $template.find("question inspectionFormat[id = '" + $(this).attr("id") + "']").attr("id") != null;
		});
		
		if ($inspectionFormats.length > 0) {
			var $inspectionFormatsGroup = $.createHtmlElement("div").attr("id", "inspectionFormatsGroup")
					.css({ "max-height" : "150px", "overflow-y" : "auto" })
					.append($.createHtmlElement("p").addClass("menuFilterCaption").text("Фильтр: Форматы проверки: "));
			
			$inspectionFormats.each(function() {
				$inspectionFormatsGroup.append(
					$.createHtmlElement("p").addClass("menuFilter").append(
						$.createHtmlElement("input")
							.attr("id", $(this).attr("key"))
							.attr("name", "inspectionFormatsGroup")
							.attr("type", "checkbox")
							.removeAttr("checked")
							.change(showQuestions)
					).append(
						$.createHtmlElement("label").attr("for", $(this).attr("key")).text($(this).attr("name"))
					)
				);
			});
			
			$leftPanel.append($inspectionFormatsGroup);
		}
		
		if ((vizitType == "VT_AUDIT") || (vizitType == "VT_GEMBA")) {
			var $showOptionsGroup = $.createHtmlElement("div").attr("id", "showOptionsGroup")
				.append($.createHtmlElement("p").addClass("menuFilterCaption").text("Опции показа: "));
			
			$previousData.children("showOptions").children("showOption").each(function() {
				$showOptionsGroup.append(
						$.createHtmlElement("p").addClass("menuFilter").append(
							$.createHtmlElement("input")
								.attr("id", $(this).attr("key"))
								.attr("name", "showOptionsGroup")
								.attr("type", "radio")
								.removeAttr("checked")
								.change(showQuestions)
						).append(
							$.createHtmlElement("label").attr("for", $(this).attr("key")).text($(this).attr("name"))
						)
				);
			});
			
			$showOptionsGroup.find("input").filter(":first").attr("checked", "checked");
			$leftPanel.append($showOptionsGroup);
		}
	}
	
	$template.children("blocks").children("block").each(function() {
		var $block = $(this);
		var blockId = "odcl-mg-" + $block.attr("id");
		
		var subbranchId = $block.children("subbranch").attr("id");
		var levelKey = $block.children("subbranch").children("level").attr("key");
		
		if (!((levelKey == "SL_CA") || (levelKey == "SL_TB") && (subbranchId == employeeTbSubbranch))) {
			return; // continue
		}
		if ((mvsAreaFlag != null) && (mvsAreaFlag == "false")) {
			if ($block.find("question metric").filter("[key ^= 'M_MVS_']").size() > 0) {
				return; // continue
			}
		}
		
		$leftPanel.append($.createHtmlElement("div")
								.attr("id", blockId)
								.addClass("menuBlock menuGroup od-collapse")
								.text($block.attr("name")));
		$menuGroup = $.createHtmlElement("div")
								.attr("id", blockId + "-cnt")
								.addClass("od-hidden ID" + blockId);
		
		var $blockMetrics = $block.children("metrics").children("metric");
		$blockMetrics.attr("max", 0);
		$blockMetrics.attr("value", 0);
		
		$block.children("groups").children("group").each(function() {
			var $group = $(this);
			var groupId = blockId + "-mi-" + $group.attr("id");
			
			$blockMetrics.each(function() {
				var $metric = $(this);
				
				if (($metric.attr("key") == "M_QUALITY") || ($metric.attr("key") == "M_MVS_QUALITY")) {
					$group.attr("m-" + $metric.attr("id") + "-max", 0);
				}
			});
			
			if ($group.attr("name") != "dummy") {
				$menuGroup.append($.createHtmlElement("div")
								.attr("id", groupId)
								.addClass("menuGroup menu-sub")
								.text($group.attr("name")));
				
				$group.children("questions").children("question").each(function() {
					var $question = $(this);
					var questionId = groupId + "-q-" + $question.attr("id");
					
					$blockMetrics.each(function() {
						var $metric = $(this);
						var metricKey = $metric.attr("key");
						var points = getMaxPointsForQuestion($question, $metric.attr("id"));
						
						if ((metricKey == "M_RESULT") || (metricKey == "M_QUALITY_CHECKUP") 
								|| (metricKey == "M_STANDARDS") || (metricKey == "M_MVS_STANDARDS") 
								|| (metricKey == "M_SALES_TECH") || (metricKey == "M_MVS_SALES_TECH") 
								|| (metricKey == "M_KNOWLEDGE") || (metricKey == "M_MVS_KNOWLEDGE")) {
							
							$metric.attr("max", parseInt($metric.attr("max")) + parseInt(points));
							
						} else if (($metric.attr("key") == "M_QUALITY") || ($metric.attr("key") == "M_MVS_QUALITY")) {
							var groupMetricAttr = "m-" + $metric.attr("id") + "-max";
							$group.attr(groupMetricAttr, parseInt($group.attr(groupMetricAttr)) + parseInt(points));
						}
					});
					
					var $questionElement = $.createHtmlElement("div")
												.attr("id", questionId)
												.addClass("QuestionPanel od-hidden ID" + groupId);
					var $questionAnswerField = $.createHtmlElement("div").addClass("question_result").css("align", "center");
					var $buttonField = $.createHtmlElement("div").addClass("buttonActivityContainer");
					var $activityInfoField = $.createHtmlElement("div");
					
					var $questionActivities = $activities.filter("[questionId = '" + $question.attr("id") + "']");
					if ($questionActivities.size() > 0) {
						$activityInfoField.append($.createHtmlElement("p").text("Мероприятия: "));
						
						var $activityList = $.createHtmlElement("ul").addClass("activityList");
						$questionActivities.each(function() {
							var text = $(this).attr("name") + " (до " + $(this).attr("dueDate") + ")";
							$activityList.append($.createHtmlElement("li").append($.createActivityLink($(this).attr("id"), text)));
						});
						$activityInfoField.append($activityList);
					}
					
					if ($question.attr("dependOnQuestionId") != null) {
						$questionElement.addClass("dependent");
						var $mainQuestion = $template.find("question[id = '" + $question.attr("dependOnQuestionId") + "']");
						if ($mainQuestion.children("dependencies").size() == 0) {
							$mainQuestion.append($.createXmlElement("dependencies"));
						}
						var $dependentQuestion = $.createXmlElement("dependentQuestion");
						$dependentQuestion.attr("id", $question.attr("id"));
						$dependentQuestion.attr("itemId", $question.children("dependOnAnswer").attr("id"));
						$mainQuestion.children("dependencies").append($dependentQuestion);
					}
					var hasDependencies = ($template.find("question[dependOnQuestionId = '" + $question.attr("id") + "']").size() != 0);
					
					var $maxPoints = null;
					var points = getMaxPointsForQuestion($question, $template.find("metric[key = 'M_RESULT']").attr("id"));
					if (points > 0) {
						$maxPoints = $.createHtmlElement("div").css('float','right').html("Вес вопроса: " + addPointText(points));
					}
					
					$questionElement.append(
						$.createHtmlElement("table").append(
							$.createHtmlElement("tr").append(
								$.createHtmlElement("td").attr("width", "60%").append(
									$.createHtmlElement("div")
										.addClass("question")
										.html($question.attr("num") + ". " + $question.children("text").text() + 
												((vizitType != "VT_GEMBA") && ($question.attr("mandatory") == "true") ||
												 (vizitType == "VT_GEMBA") && ($question.attr("mandatoryCertificationFlag") == "true")
														? " (*)" : ""))
								).append(
									$.createHtmlElement("div")
										.addClass("question_desc")
										.html($question.children("desc").text())
								)
							).append(
								$.createHtmlElement("td").addClass("splitter")
							).append(
								$.createHtmlElement("td").attr("width", "40%")
								    .append($maxPoints)
									.append($questionAnswerField)
									.append($buttonField)
									.append($activityInfoField)
							)
						)
					);
					
					var answerType = $question.children("answerType").attr("key");
					var $storedAnswer = $storedAnswers.filter("[questionId = '" + $question.attr("id") + "']");
					var $previousAnswer = $previousAnswers.filter("[questionId = '" + $question.attr("id") + "']");
					
					$question.attr("answerId", $storedAnswer.attr("id"));
					
					if (answerType == "AT_STRING") {
						var $stringElement = $.createHtmlElement("input")
								.attr("name", questionId)
								.attr("type", "text")
								.val($storedAnswer.children("stringValue").text())
								.change(function() {
									answersChanged = true;
								});
						if ($question.attr("answerMask") != null) {
							$stringElement.mask($question.attr("answerMask"));
						}
						if (readOnly && (taskId != null)) {
							$stringElement.attr("disabled", true);
						}
						$questionAnswerField.append($stringElement);
								
					} else if (answerType == "AT_NUMERIC") {
						var $numericElement = $.createHtmlElement("input")
								.attr("name", questionId)
								.attr("type", "text")
								.val($storedAnswer.children("numberValue").text())
								.numeric({ decimal : "," })
								.change(function() {
									answersChanged = true;
									countMetrics();
								});
						if (readOnly && (taskId != null)) {
							$numericElement.attr("disabled", true);
						}
						$questionAnswerField.append($numericElement);

					} else if (answerType == "AT_DATE") {
						var $dateElement = $.createHtmlElement("input")
								.attr("name", questionId)
								.attr("type", "text")
								.val($storedAnswer.children("dateValue").text())
								.mask("99.99.9999")
								.change(function() {
									answersChanged = true;
								});
						if (readOnly && (taskId != null)) {
							$dateElement.attr("disabled", true);
						}
						$questionAnswerField.append($dateElement);
						
						$questionAnswerField.append(
							$.createHtmlElement("table").append(
								$.createHtmlElement("tr").append(
									$.createHtmlElement("td").append($dateElement)
								)
							).append(
								$.createHtmlElement("tr").append(
									$.createHtmlElement("td").addClass("question_desc").text("Поддерживаемый шаблон: ДД.ММ.ГГГГ")
								)
							)
						);

					} else if (answerType == "AT_MEMO") {
						var $memoElement = $.createHtmlElement("textarea")
								.attr("cols", "40").attr("rows", "10")
								.attr("name", questionId)
								.val($storedAnswer.children("stringValue").text())
								.change(function() {
									answersChanged = true;
								});
						if (readOnly && (taskId != null)) {
							$memoElement.attr("disabled", true);
						}
						$questionAnswerField.append($memoElement);

					} else if (answerType == "AT_DDLIST-ONE") {
						var storedItemId = $storedAnswer.children("items").children("item").attr("id");
						var previousItemId = $previousAnswer.children("items").children("item").attr("id");
						var $selectElement = $.createHtmlElement("select")
								.attr("name", questionId)
								.change(function() {
									answersChanged = true;
									countMetrics();
								});
						
						if (hasDependencies) {
							$selectElement.change({question: $question}, showDependencies);
						}
						
						$question.children("dic").children("items").children("item").each(function() {
							var $item = $(this);
							var answerItemId = questionId + "_" + $item.attr("id");
							
							var $optionElement = $.createHtmlElement("option")
													.attr("id", answerItemId)
													.val($item.attr("name")).text($item.attr("name"));
							if ($item.attr("id") == storedItemId) {
								$optionElement.attr("selected", "selected");
							} else {
								$optionElement.removeAttr("selected");
							}
							if ($item.attr("id") == previousItemId) {
								$optionElement.css("font-weight", "bold");
							}
							if (readOnly && (taskId != null)) {
								$optionElement.attr("disabled", true);
							}
							
							$selectElement.append($optionElement);
						});
						
						$questionAnswerField.append($selectElement);
						
					} else if (answerType == "AT_CHECKLIST") {
						var $items = $question.children("dic").children("items").children("item");
						var $storedItems = $storedAnswer.children("items").children("item");
						var $previousItems = $previousAnswer.children("items").children("item");
						
						$items.each(function() {
							var $item = $(this);
							var answerItemId = questionId + "_" + $item.attr("id");
							
							var $checkboxElement = $.createHtmlElement("input")
													.attr("id", answerItemId)
													.attr("name", questionId)
													.attr("type", "checkbox")
													.change(function() {
														answersChanged = true;
														countMetrics();
													});
							if ($storedItems.filter("[id = '" + $item.attr("id") + "']").size() == 1) {
								$checkboxElement.attr("checked", "checked");
							} else {
								$checkboxElement.removeAttr("checked");
							}
							if (readOnly && (taskId != null)) {
								$checkboxElement.attr("disabled", true);
							}
							if (hasDependencies) {
								$checkboxElement.change({question: $question}, showDependencies);
							}
							
							var $checkboxElementLabel = $.createHtmlElement("label")
													.attr("for", answerItemId)
													.text($item.attr("name"));
							if ($previousItems.filter("[id = '" + $item.attr("id") + "']").size() == 1) {
								$checkboxElement.css("font-weight", "bold");
							}
							$questionAnswerField.append($.createHtmlElement("p").append($checkboxElement).append($checkboxElementLabel));
						});
						
					} else if (answerType == "AT_RADIO") {
						var $items = $question.children("dic").children("items").children("item");
						var storedItemId = $storedAnswer.children("items").children("item").attr("id");
						var previousItemId = $previousAnswer.children("items").children("item").attr("id");
						
						$items.each(function() {
							var $item = $(this);
							var answerItemId = questionId + "_" + $item.attr("id");
							
							var $radioElement = $.createHtmlElement("input")
													.attr("id", answerItemId)
													.attr("name", questionId)
													.attr("type", "radio")
													.change(function() {
														answersChanged = true;
														countMetrics();
													});
							if (($item.attr("id") == storedItemId) || ($item.attr("id") == previousItemId) && (storedItemId == null)) {
								$radioElement.attr("checked", "checked");
							} else {
								$radioElement.removeAttr("checked");
							}
							if (readOnly && (taskId != null)) {
								$radioElement.attr("disabled", true);
							}
							if ((vizitType == "VT_AUDIT") || (vizitType == "VT_GEMBA")) {
								if ((previousItemId == null) || (previousItemId == "") 
										|| ($items.filter("[id = '" + previousItemId + "']").attr("positiveFlag") == "false")) {
									if ($item.attr("positiveFlag") == "true") {
										$radioElement.attr("disabled", true);
									}
								}
							}
							if (hasDependencies) {
								$radioElement.change({question: $question}, showDependencies);
							}
							
							var $radioElementLabel = $.createHtmlElement("label")
													.attr("for", answerItemId)
													.text($item.attr("name"));
							if ($item.attr("id") == previousItemId) {
								$radioElementLabel.css("font-weight", "bold");
							}
							
							$questionAnswerField.append($.createHtmlElement("p").append($radioElement).append($radioElementLabel));
						});
					}
					
					if ($question.attr("activityCreationFlag") == "true") {
						var $activityButton = $.createActivityButton($question.attr("id"));
						if (readOnly) {
							$activityButton.attr("disabled", true);
						}
						$buttonField.append($activityButton);
					}
					
					$rightPanel.append($questionElement);
				});
				
				$leftPanel.append($menuGroup);
			}
		});
	});
	
	$rightPanel.append(
		$.createHtmlElement("a")
			.addClass("upPagePanel").css("display", "block")
			.attr("href", "#").attr("title", "Наверх")
			.text("Наверх страницы")
			.click(function() {
				$("#rightPanel").animate({ scrollTop : 0 }, "slow"); return false;
			})
	);
	
	$(".menuBlock").click(function() {
		var instance = $(this);

		$(".menuBlock").not(instance).each(function() {
			collapseBlock($(this));
		});
		$(".menuDummyBlock").not(instance).each(function() {
			collapseBlock($(this));
		});

		if (instance.hasClass("od-collapse")) {
			expandBlock(instance);
			$("#" + instance.attr("id") + "-mi-0").click();
			
			countMetrics();
		}
	});
	
	$(".QuestionPanel").hide().removeClass("od-hidden");

	$(".menu-sub, .menuDummyBlock").click(function() {
		var instance = $(this);
		$(".menu-sub").not(instance).removeClass("od-selected");
		$(".QuestionPanel").hide();
		$(".ID" + instance.attr("id")).not(".dependent").show();
		instance.addClass("od-selected");
		if ((vizitType == "VT_SELF") || (vizitType == "VT_AUDIT") || (vizitType == "VT_GEMBA")) {
			showQuestions();
		}
	});

	$(".menuBlock").first().click();
	$(".menu-sub").first().click();
};

/******************************************************************************
 * Description: 
 * Return: 		
 *****************************************************************************/
function collapseBlock(instance) {
	instance.removeClass("od-expand").addClass("od-collapse");
	$(".ID" + instance.attr("id")).removeClass("od-show").addClass("od-hidden");
};

/******************************************************************************
 * Description: 
 * Return: 		
 *****************************************************************************/
function expandBlock(instance) {
	instance.removeClass("od-collapse").addClass("od-expand");
	$(".ID" + instance.attr("id")).removeClass("od-hidden").addClass("od-show");
};

/******************************************************************************
 * Description: 
 * Return: 		
 *****************************************************************************/
function GetAnswers() {
	$previousData.find("storedAnswers answer").remove();
	
	$(".QuestionPanel").each(function() {
		var questionBlockId = $(this).attr("id");
		var questionId = questionBlockId.substring(questionBlockId.indexOf("-q-") + 3);
		var $question = $template.find("question[id = '" + questionId + "']");
		
		var $answer = $.createXmlElement("answer");
		$answer.attr("id", $question.attr("answerId"));
		$answer.attr("questionId", $question.attr("id"));
		$answer.attr("taskId", taskId);
		var answerType = $question.children("answerType").attr("key");
		
		if (answerType == "AT_NUMERIC") {
			$answer.append($.createXmlElement("numberValue").text($("#" + questionBlockId + " input").val()));
			
		} else if (answerType == "AT_DATE") {
			$answer.append($.createXmlElement("dateValue").text($("#" + questionBlockId + " input").val()));
			
		} else if (answerType == "AT_STRING") {
			$answer.append($.createXmlElement("stringValue").text($("#" + questionBlockId + " input").val()));
			
		} else if (answerType == "AT_MEMO") {
			$answer.append($.createXmlElement("stringValue").text($("#" + questionBlockId + " textarea").val()));
			
		} else if (answerType == "AT_DDLIST-ONE") {
			var $items = $.createXmlElement("items");
			
			var itemId = $("#" + questionBlockId + " :selected").attr("id");
			if (itemId != null) {
				itemId = itemId.substring(itemId.lastIndexOf("_") + 1);
				$items.append($question.find("dic item[id = '" + itemId + "']").clone());
			}
			
			$answer.append($items.clone());
			
		} else if ((answerType == "AT_RADIO") || (answerType == "AT_CHECKLIST")) {
			var $items = $.createXmlElement("items");
			
			$("#" + questionBlockId + " input:checked").each(function() {
				var itemId = $(this).attr("id");
				itemId = itemId.substring(itemId.lastIndexOf("_") + 1);
				$items.append($question.find("dic item[id = '" + itemId + "']").clone());
			});
			
			$answer.append($items.clone());
		}
		
		$previousData.children("storedAnswers").append($answer.clone());
	});
	
	$previousData.find("blockMetrics blockMetric").remove();
	
	$template.children("blocks").children("block").each(function() {
		var $block = $(this);
		
		$block.children("metrics").children("metric").each(function() {
			var $metric = $(this);
			
			var $blockMetric = $.createBlockMetric($block.attr("id"), $metric.attr("id"), null, $metric.attr("value"));
			$previousData.children("blockMetrics").append($blockMetric.clone());
			
			if ( ( (vizitType == "VT_AUDIT") || (vizitType == "VT_GEMBA") ) && ($metric.attr("key") == "M_RESULT") ) {
				var dispersion = (previousValue > 0) ? (1 - $metric.attr("value") / previousValue) : 0;
				var reduction = $reduceIndexes.filter(function(index) {
					return ($(this).attr("dispStartValue") < dispersion) && ($(this).attr("dispEndValue") >= dispersion);
				}).attr("value");
				reduction = (reduction == null) ? 1 : reduction;
				var dispersedResult = $metric.attr("value") * reduction;
				
				var $blockMetric = $.createBlockMetric($block.attr("id"), null, "M_DISPERSION", dispersion);
				$previousData.children("blockMetrics").append($blockMetric.clone());
				
				var $blockMetric = $.createBlockMetric($block.attr("id"), null, "M_REDUCE_INDEX", reduction);
				$previousData.children("blockMetrics").append($blockMetric.clone());
				
				var $blockMetric = $.createBlockMetric($block.attr("id"), null, "M_DISPERSED_RESULT", dispersedResult);
				$previousData.children("blockMetrics").append($blockMetric.clone());
			}
		});
	});
	
	return $previousData.xml().toString();
};

/******************************************************************************
 * Description: 
 * Return: 		
 *****************************************************************************/
function ReadAnswers() {
	$("#checklistForm\\:currentAnswerXml").val(GetAnswers());
};

/******************************************************************************
 * Description: 
 * Return: 		
 *****************************************************************************/
function countMetrics() {
	var menuBlockId = $(".menuBlock.od-expand").attr("id");
	if (menuBlockId != null) {
		var blockId = menuBlockId.substring(menuBlockId.indexOf("-mg-") + 4);
		var $block = $template.find("block[id = '" + blockId + "']");
		
		$block.children("metrics").children("metric").each(function() {
			var $metric = $(this);
			var metricId = $metric.attr("id");
			var metricKey = $metric.attr("key");
			
			$metric.attr("value", 0);
			
			$block.find("group").each(function() {
				var $group = $(this);
				var groupPoints = 0;
				
				$group.find("question").each(function() {
					var $question = $(this);
					var answerType = $question.children("answerType").attr("key");
					var $items = null;
					
					if ((answerType == "AT_RADIO") || (answerType == "AT_CHECKLIST")) {
						$items = $(".QuestionPanel[id $= '-q-" + $question.attr("id") + "']").find(" input:checked");
						
					} else if (answerType == "AT_DDLIST-ONE") {
						$items = $(".QuestionPanel[id $= '-q-" + $question.attr("id") + "']").find(" :selected");
					}
					
					if ($items != null) {
						$items.each(function() {
							var itemId = $(this).attr("id");
							itemId = itemId.substring(itemId.lastIndexOf("_") + 1);
							
							var points = $question.find("metricDicItem").filter(function(index) {
								return 	($(this).children("dicItem").attr("id") == itemId) && 
										($(this).children("metric").attr("id") == metricId);
							}).attr("answerPoints");
							points = (points == null) ? 0 : points;
							
							if ((metricKey == "M_RESULT") || (metricKey == "M_QUALITY_CHECKUP") 
									|| (metricKey == "M_STANDARDS") || (metricKey == "M_MVS_STANDARDS") 
									|| (metricKey == "M_SALES_TECH") || (metricKey == "M_MVS_SALES_TECH") 
									|| (metricKey == "M_KNOWLEDGE") || (metricKey == "M_MVS_KNOWLEDGE")) {
								
								$metric.attr("value", parseInt($metric.attr("value")) + parseInt(points));
	
							} else if ((metricKey == "M_QUALITY") || (metricKey == "M_MVS_QUALITY")) {
								groupPoints = parseInt(groupPoints) + parseInt(points);
							}
						});
					}
					
					if (answerType == "AT_NUMERIC") {
						var value = $(".QuestionPanel[id $= '-q-" + $question.attr("id") + "']").find(" input").val();
						
						var points = $question.find("answerRange").filter(function(index) {
							return 	($(this).children("range").attr("startValue") <= value) && 
									($(this).children("range").attr("endValue") >= value);
						}).attr("answerPoints");
						points = (points == null) ? 0 : points;
						
						if (metricKey == "M_RESULT") {
							$metric.attr("value", parseInt($metric.attr("value")) + parseInt(points));
						}
					}
				});
				
				if ((metricKey == "M_QUALITY") || (metricKey == "M_MVS_QUALITY")) {
					var rate = $group.find("qroupMetric metric[id = '" + metricId + "']").parent().attr("rate");
					if (rate == null) {
						rate = 0.0;
					}
					var groupMaxPoints = $group.attr("m-" + metricId + "-max");
					if ((groupMaxPoints != null) && (parseFloat(groupMaxPoints) > 0)) {
						$metric.attr("value", parseFloat($metric.attr("value")) + parseFloat(groupPoints) * parseFloat(rate) / parseFloat(groupMaxPoints));
					}
				}
			});
		});
		
		createTable($block);
	}
};

/******************************************************************************
 * Description: 
 * Return: 		
 *****************************************************************************/
function getMaxPointsForQuestion($question, metricId) {
	var listMetrics = $question.find("metricDicItem metric[id = '" + metricId + "']").parent().map(function() {
		return $(this).attr("answerPoints");
	}).get();
	var maxForMetrics = (listMetrics.length > 0) ? Math.max.apply(Math, listMetrics) : 0;
	
	var listRanges = $question.find("answerRange").map(function() {
		return $(this).attr("answerPoints");
	}).get();
	var listForRanges = (listRanges.length > 0) ? Math.max.apply(Math, listRanges) : 0;
	
	return Math.max(maxForMetrics, listForRanges);
};

/******************************************************************************
 * Description: 
 * Return: 		
 *****************************************************************************/
function createTable($block) {
	$("#metricTable").find("tr").remove();
	
	$block.children("metrics").children("metric").each(function() {
		var $metric = $(this);
		var metricKey = $metric.attr("key");
		
		if ((vizitType == "VT_SELF") || (vizitType == "VT_AUDIT") || (vizitType == "VT_GEMBA")) {
			if (metricKey == "M_RESULT") {
				var targetValue = Math.round($metric.attr("max") * targetPercent);
				var color = ($metric.attr("value") < targetValue) ? "red" : "white";
				
				$("#metricTable").append(
					$.createHtmlElement("tr").append(
						$.createHtmlElement("td").attr("width", "220").text("Максимальная сумма баллов:")
					).append(
						$.createHtmlElement("td").attr("width", "180").text(addPointText($metric.attr("max")))
					).append(
						$.createHtmlElement("td").attr("width", "220").text("Цель:")
					).append(
						$.createHtmlElement("td").attr("width", "180").text(addPointText(targetValue) + " (" + Math.round(targetPercent * 100) + "%)")
					)
				).append(
					$.createHtmlElement("tr").append(
						$.createHtmlElement("td").text("Результат предыдущей проверки:")
					).append(
						$.createHtmlElement("td").text(addPointText(previousValue) + 
								((targetValue != 0) ? (" (" + Math.round(previousValue * 100 / targetValue) + "% от цели)") : ""))
					).append(
						$.createHtmlElement("td").text("Результат текущей проверки:")
					).append(
						$.createHtmlElement("td").text(addPointText($metric.attr("value")) + 
								((targetValue != 0) ? (" (" + Math.round($metric.attr("value") * 100 / targetValue) + "% от цели)") : ""))
								.css("color", color)
					)
				);
				
				if (vizitType != "VT_SELF") {
					var dispersionDiff = (previousValue > 0) ? (previousValue - $metric.attr("value")) : 0;
					var dispersion = (previousValue > 0) ? (dispersionDiff / previousValue) : 0;
					var reduction = $reduceIndexes.filter(function(index) {
						return ($(this).attr("dispStartValue") < dispersion) && ($(this).attr("dispEndValue") >= dispersion);
					}).attr("value");
					reduction = (reduction == null) ? 1 : reduction;
					
					$("#metricTable").append(
						$.createHtmlElement("tr").append(
							$.createHtmlElement("td").text("Текущая дисперсия:")
						).append(
							$.createHtmlElement("td").text(addPointText(dispersionDiff) + " (" + Math.round(10000 * dispersion) / 100 + "%)")
						).append(
							$.createHtmlElement("td").text("Понижающий коэффициент:")
						).append(
							$.createHtmlElement("td").text(100 * reduction + "%")
						)
					).append(
						$.createHtmlElement("tr").append(
							$.createHtmlElement("td").text("Результат с учетом дисперсии:")
						).append(
							$.createHtmlElement("td").text(addPointText(Math.round(100 * $metric.attr("value") * reduction) / 100))
						).append(
							$.createHtmlElement("td").text("Рейтинг:")
						).append(
							$.createHtmlElement("td").text(Math.round(10000 * $metric.attr("value") * reduction / $metric.attr("max")) / 100 + "%")
						)
					);
					
				} else {
					$("#metricTable").append(
						$.createHtmlElement("tr").append(
							$.createHtmlElement("td").attr("colspan", "2").css("text-align", "right").text("Рейтинг:")
						).append(
							$.createHtmlElement("td").attr("colspan", "2").text(Math.round(10000 * $metric.attr("value") / $metric.attr("max")) / 100 + "%")
						)
					);
				}
			}
			
		} else {
			if (metricKey == "M_RESULT") {
				$("#metricTable").append(
					$.createHtmlElement("tr").append(
						$.createHtmlElement("td").attr("width", "400").text($metric.attr("name"))
					).append(
						$.createHtmlElement("td").attr("width", "400").text(addPointText($metric.attr("value")) + 
								" (" + Math.round($metric.attr("value") * 100 / $metric.attr("max")) + "%)")
					)
				);
				
			} else if ((metricKey == "M_STANDARDS") || (metricKey == "M_MVS_STANDARDS") 
					|| (metricKey == "M_SALES_TECH") || (metricKey == "M_MVS_SALES_TECH") 
					|| (metricKey == "M_KNOWLEDGE") || (metricKey == "M_MVS_KNOWLEDGE") 
					|| (metricKey == "M_QUALITY") || (metricKey == "M_MVS_QUALITY")
					|| (metricKey == "M_QUALITY_CHECKUP")) {
				
				if (($metric.attr("max") != null) && ($metric.attr("max") > 0)) {
					$metric.attr("value", $metric.attr("value") / $metric.attr("max"));
				}
				$("#metricTable").append(
					$.createHtmlElement("tr").append(
						$.createHtmlElement("td").attr("width", "400").text($metric.attr("name"))
					).append(
						$.createHtmlElement("td").attr("width", "400").text(Math.round($metric.attr("value") * 10000) / 100 + " %")
					)
				);
			}
		}
	});
};

/******************************************************************************
 * Description: 
 * Return: 		
 *****************************************************************************/
function showQuestions() {
	var option = $("#showOptionsGroup input:checked").attr("id");
	var $allFormats = $("#inspectionFormatsGroup input");
	var $formats = $("#inspectionFormatsGroup input:checked");
	
	$(".QuestionPanel.ID" + $(".menu-sub.od-selected").attr("id")).each(function() {
		var $questionBlock = $(this);
		var questionBlockId = $questionBlock.attr("id");
		var questionId = questionBlockId.substring(questionBlockId.indexOf("-q-") + 3);
		
		var visible = true;
		
		if ($allFormats.length > 0) {
			if ($formats.length > 0) {
				var $questionFormats = $template.find("question[id = '" + questionId + "'] inspectionFormat");
				
				$questionFormats = $questionFormats.filter(function(index) {
					return ($formats.filter("[id = '" + $(this).attr("key") + "']").attr("id") != null);
				});
				
				visible &= ($questionFormats.size() > 0);
			}
		}
		
		if (option != null) {
			$answers = ($previousAnswers.size() > 0) ? $previousAnswers : $storedAnswers;
			var $item = $answers.filter("[questionId = '" + questionId + "']").find("item");
			
			if (option == "DI_SHOW_OPTION_YES") {
				visible &= ($item.attr("key") == "DI_YES_CERTIFICATION");
				
			} else if (option == "DI_SHOW_OPTION_NO") {
				visible &= ($item.attr("key") == "DI_NO_CERTIFICATION");
			}
		}
		
		if (visible) {
			$questionBlock.show();
		} else {
			$questionBlock.hide();
		}
		
	});
};

/******************************************************************************
 * Description: 
 * Return: 		
 *****************************************************************************/
function showDependencies(event) {
	var $question = event.data.question;
	var answerType = $question.children("answerType").attr("key");
	var $items = null;
	
	if ((answerType == "AT_RADIO") || (answerType == "AT_CHECKLIST")) {
		$items = $(".QuestionPanel[id $= '-q-" + $question.attr("id") + "']").find(" input:checked");
		
	} else if (answerType == "AT_DDLIST-ONE") {
		$items = $(".QuestionPanel[id $= '-q-" + $question.attr("id") + "']").find(" :selected");
	}
	
	$question.children("dic").children("items").children("item").each(function() {
		var $item = $(this);
		
		$question.children("dependencies").children("dependentQuestion").each(function() {
			var $dependency = $(this);
			var $dependentQuestion = $template.find("question[id = '" + $dependency.attr("id") + "']");
			var $dependentQuestionPanel = $(".QuestionPanel[id $= '-q-" + $dependency.attr("id") + "']");
			
			if ($dependency.attr("itemId") == $item.attr("id")) {
				if ($items.filter("[id $= '_" + $item.attr("id") + "']").size() != 0) {
					$dependentQuestionPanel.removeClass("dependent");
					if ($dependentQuestion.parent().parent().attr("id") == $question.parent().parent().attr("id")) {
						$dependentQuestionPanel.show();
					}
					
					showDependentQuestions($dependentQuestion, $question.parent().parent().attr("id"));
					
				} else {
					$dependentQuestionPanel.addClass("dependent");
					if ($dependentQuestion.parent().parent().attr("id") == $question.parent().parent().attr("id")) {
						$dependentQuestionPanel.hide();
					}
					
					hideDependentQuestions($dependentQuestion, $question.parent().parent().attr("id"));
				}
			}
		});
	});
};

/******************************************************************************
 * Description: 
 * Return: 		
 *****************************************************************************/
function showDependentQuestions($question, currentGroupId) {
	var answerType = $question.children("answerType").attr("key");
	var $items = null;
	
	if ((answerType == "AT_RADIO") || (answerType == "AT_CHECKLIST")) {
		$items = $(".QuestionPanel[id $= '-q-" + $question.attr("id") + "']").find(" input:checked");
		
	} else if (answerType == "AT_DDLIST-ONE") {
		$items = $(".QuestionPanel[id $= '-q-" + $question.attr("id") + "']").find(" :selected");
	}
	
	$question.children("dic").children("items").children("item").each(function() {
		var $item = $(this);
		
		$question.children("dependencies").children("dependentQuestion").each(function() {
			var $dependency = $(this);
			var $dependentQuestion = $template.find("question[id = '" + $dependency.attr("id") + "']");
			var $dependentQuestionPanel = $(".QuestionPanel[id $= '-q-" + $dependency.attr("id") + "']");
			
			if ($dependency.attr("itemId") == $item.attr("id")) {
				if ($items.filter("[id $= '_" + $item.attr("id") + "']").size() != 0) {
					$dependentQuestionPanel.removeClass("dependent");
					if (($question.parent().parent().attr("id") == currentGroupId)
							&& ($dependentQuestion.parent().parent().attr("id") == $question.parent().parent().attr("id"))) {
						$dependentQuestionPanel.show();
					}
					
					showDependentQuestions($dependentQuestion, currentGroupId);
				}
			}
		});
	});
};

/******************************************************************************
 * Description: 
 * Return: 		
 *****************************************************************************/
function hideDependentQuestions($question, currentGroupId) {
	$question.children("dependencies").children("dependentQuestion").each(function() {
		var $dependency = $(this);
		var $dependentQuestion = $template.find("question[id = '" + $dependency.attr("id") + "']");
		var $dependentQuestionPanel = $(".QuestionPanel[id $= '-q-" + $dependency.attr("id") + "']");
		
		$dependentQuestionPanel.addClass("dependent");
		if (($question.parent().parent().attr("id") == currentGroupId)
				&& ($dependentQuestion.parent().parent().attr("id") == $question.parent().parent().attr("id"))) {
			$dependentQuestionPanel.hide();
		}
		
		hideDependentQuestions($dependentQuestion, currentGroupId);
	});
};

/******************************************************************************
 * Description: function checks questions with mandatory answers
 * Return: 		true - when all mandatory fields are filled, 
 * 				false - otherwise (not all mandatory fields are filled)
 *****************************************************************************/
function ValidateCL() {
	var fulfilled = true;
	
	$template.find("question").filter("[mandatory = 'true'],[mandatoryCertificationFlag = 'true']").each(function() {
		var $question = $(this);
		var $questionPanel = $(".QuestionPanel").filter("[id $= '-q-" + $question.attr("id") + "']");
		var questionBlockId = $questionPanel.attr("id");
		var answerType = $question.children("answerType").attr("key");
		
		if ((vizitType != "VT_GEMBA") && ($question.attr("mandatory") == "true")
				|| (vizitType == "VT_GEMBA") && ($question.attr("mandatoryCertificationFlag") == "true")) {
			
			if (questionBlockId != null) {
				if ((answerType == "AT_NUMERIC") || (answerType == "AT_DATE") || (answerType == "AT_STRING")) {
					if ($("#" + questionBlockId + " input").val() == null) {
						fulfilled = false;
						$questionPanel.addClass("shouldBeAnswered");
						// return false; // break
						
					} else {
						$questionPanel.removeClass("shouldBeAnswered");
					}
					
				} else if (answerType == "AT_MEMO") {
					if ($("#" + questionBlockId + " textarea").val() == null) {
						fulfilled = false;
						$questionPanel.addClass("shouldBeAnswered");
						// return false; // break
						
					} else {
						$questionPanel.removeClass("shouldBeAnswered");
					}
					
				} else if (answerType == "AT_DDLIST-ONE") {
					if ($("#" + questionBlockId + " :selected").attr("id") == null) {
						fulfilled = false;
						$questionPanel.addClass("shouldBeAnswered");
						// return false; // break
						
					} else {
						$questionPanel.removeClass("shouldBeAnswered");
					}
					
				} else if ((answerType == "AT_RADIO") || (answerType == "AT_CHECKLIST")) {
					if ($("#" + questionBlockId + " input:checked").attr("id") == null) {
						fulfilled = false;
						$questionPanel.addClass("shouldBeAnswered");
						// return false; // break
						
					} else {
						$questionPanel.removeClass("shouldBeAnswered");
					}
				}
			}
		}
	});
	
	return fulfilled;
};

/******************************************************************************
 * Description: function checks whether the answer to any question was changed
 * Return: 		true - some answer was changed, 
 * 				false - otherwise (no one answer was changed)
 *****************************************************************************/
function isAnswersChanged() {
	return answersChanged;
};

/******************************************************************************
 * Description: 
 * Return: 		
 *****************************************************************************/
$.createBlockMetric = function(blockId, metricId, metricKey, value) {
	var $blockMetric = $.createXmlElement("blockMetric")
			.attr("value", value);
	
	var $blockMetricId = $.createXmlElement("id")
			.attr("taskId", taskId).attr("blockId", blockId).attr("metricId", metricId);
	$blockMetric.append($blockMetricId.clone());
	
	if (metricKey != null) {
		var $blockMetricItem = $.createXmlElement("metric")
				.attr("key", metricKey);
		$blockMetric.append($blockMetricItem.clone());
	}
	
	return $blockMetric;
};

/******************************************************************************
 * Description: 
 * Return: 		
 *****************************************************************************/
$.createActivityButton = function(questionId) {
	return $.createHtmlElement("button")
				.addClass("buttonActivity")
				.attr("type", "button")
				.click(function() {
					var $question = $template.find("question[id = '" + questionId + "']");
					var questionBlockId = $(".QuestionPanel").filter("[id $= '-q-" + $question.attr("id") + "']").attr("id");
					var answerType = $question.children("answerType").attr("key");
					var itemId = null;
					
					if (answerType == "AT_DDLIST-ONE") {
						itemId = $("#" + questionBlockId + " :selected").attr("id");
						if (itemId != null) {
							itemId = itemId.substring(itemId.lastIndexOf("_") + 1);
						}
						
					} else if (answerType == "AT_RADIO") {
						itemId = $("#" + questionBlockId + " input:checked").attr("id");
						if (itemId != null) {
							itemId = itemId.substring(itemId.lastIndexOf("_") + 1);
						}
					}
					
					addActivity(questionId, itemId);
				}).append($.createHtmlElement("span").text("Создать мероприятие"));
};

/******************************************************************************
 * Description: 
 * Return: 		
 *****************************************************************************/
$.createActivityLink = function(activityId, activityText) {
	return $.createHtmlElement("a")
				.text(activityText)
				.click(function() {
					openActivity(activityId);
				});
};

/******************************************************************************
 * Simple helper function creates a new html element from a name,
 * so you don't have to add the brackets etc.
 *****************************************************************************/
$.createHtmlElement = function(name) {
	return $("<" + name + " />");
};

/******************************************************************************
 * Simple helper function creates a new xml element from a name,
 * so you don't have to add the brackets etc.
 *****************************************************************************/
$.createXmlElement = function(name) {
	return $($.parseXML("<?xml version='1.0' encoding='UTF-8'?><" + name + " />")).find(name);
};

/******************************************************************************
 * Description: 
 * Return: 		
 *****************************************************************************/
Array.prototype.indexOf = function (obj, start) {
	for (var i = (start || 0); i < this.length; i++) {
		if (this[i] == obj) {
			return i;
		}
	}
	return -1;
};

/******************************************************************************
 * Description: 
 * Return: 		
 *****************************************************************************/
$.fn.xml = function() {
	var r = [];
	this.each(function() {
		r.push($.xml(this));
	});
	return r;
};
$.xml = function(el) {
	if (window.XMLSerializer) {
		return (new XMLSerializer()).serializeToString(el);
	}
	var qw = function(s) {
		return '"' + s.replace(/"/g, '&quot;') + '"';
	};
	if (!el) {
		return "(null)";
	}
	var res = "";
	var tag = el.nodeName;
	var tagShow = tag.charAt(0) != "#";
	if (tagShow) {
		res += '<' + tag;
	}
	if (el.attributes) {
		res += $.map(
				el.attributes,
				function(attr) {
					if (attr.specified && attr.name.charAt(0) != '$')
						return ' ' + attr.name + '=' + qw(attr.value);
				}).join('');
	}
	if (tagShow && el.nodeValue == null && !el.hasChildNodes()) {
		return res + " />";
	}
	if (tagShow) {
		res += ">";
	}
	if (el.nodeType == 8) {
		res += "<!-- " + el.nodeValue + " -->";
	} else if (el.nodeValue != null) {
		res += encodeXml(el.nodeValue);
	}
	if (el.hasChildNodes && el.hasChildNodes()) {
		res += $.map(el.childNodes, function(child) {
			return $.xml(child);
		}).join('');
	}
	if (tagShow) {
		res += '</' + tag + '>';
	}
	return res;
};
function encodeXml(s) {
	return (s.
			replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/'/g, '&apos;').replace(/</g, '&lt;').
			replace(/>/g, '&gt;').replace(/\t/g, '&#x9;').replace(/\n/g, '&#xA;').replace(/\r/g, '&#xD;')
	);
};

/******************************************************************************
 * Description: 
 * Return: 		
 *****************************************************************************/
function U(val) {
	if (typeof (val) == "undefined") {
		return "";
	}
	return val;
};

/******************************************************************************
 * Description: 
 * Return: 		
 *****************************************************************************/
function addPointText(number) {
	var unit = number % 10;
	var tens = Math.round(number / 10);
	var text = number + " балл";
	
	if ((tens != 1) && (unit == 1)) {
		text += "";
	} else if ((tens != 1) && (unit >= 2) && (unit <= 4)) {
		text += "а";
	} else {
		text += "ов";
	}
	
	return text;
};