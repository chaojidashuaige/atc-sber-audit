$(function() {
});

var $template;
var $previousData;
var $storedAnswers;
var $previousAnswers;

var taskId;
var vizitType;
var targetPercent;
var previousValue;
var $reduceIndexes;
var $activities;

var questionMap;
var questionPanelMap;
var questionGroupMap;
var dependentMap;
var blockMap;

var answersChanged;

/******************************************************************************
 * Description: 
 * Return: 		
 *****************************************************************************/
function LoadCL(templateXml, previousDataXml, readOnly) {
	if ((templateXml === 0) || (templateXml.length === 0)) {
		return;
	}
	var QA = $($.parseXML(templateXml));
	//var start = new Date().getTime();
	/*
	var $leftPanel = $.createHtmlElement("div").attr("id", "leftPanel").addClass("leftPanel");
	var $rightPanel = $.createHtmlElement("div").attr("id", "rightPanel").addClass("rightPanelContent");
	*/
	/*var $root = */$("#checklistForm\\:checklistBody").html(
		$.createHtmlElement("root").append(
			$.createHtmlElement("div").addClass("rightPanel").append(
				$.createHtmlElement("div").addClass("rightPanelFull").append(
					$.createHtmlElement("div").addClass("ResultsPanel").append(
						$.createHtmlElement("table").attr("id", "metricTable")
					)
				).append(
					/*$rightPanel*/$.createHtmlElement("div").attr("id", "rightPanel").addClass("rightPanelContent").append(
						$.createHtmlElement("a").attr("name", "top")
					)
				)
			)
		).append(
			/*$leftPanel*/$.createHtmlElement("div").attr("id", "leftPanel").addClass("leftPanel")
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

	$template = $(QA).children("template");
	
	var mvsAreaFlag = $previousData.attr("mvsAreaFlag");
	var employeeTbSubbranch = $previousData.attr("employeeTbSubbranch");
	taskId = $previousData.attr("taskId");
	vizitType = $previousData.attr("visitType");
	targetPercent = $previousData.attr("targetPercent");
	previousValue = $previousData.attr("previousValue");
	$reduceIndexes = $previousData.find("reduceIndex");
	$activities = $previousData.children("activities").children("activity");
	answersChanged = false;
	
	questionMap = {};
	questionPanelMap = {};
	questionGroupMap = {};
	dependentMap = {};
	blockMap = {};
	
	if ((vizitType === "VT_SELF") || (vizitType === "VT_AUDIT") || (vizitType === "VT_GEMBA")) {
		var $inspectionFormats = $previousData.children("inspectionFormats").children("inspectionFormat").filter(function(index) {
			return $template.find("question inspectionFormat[id = '" + $(this).attr("id") + "']").attr("id") != null;
		});
		
		if ($inspectionFormats.length > 0) {
			var $inspectionFormatsGroup = $.createHtmlElement("div").attr("id", "inspectionFormatsGroup")
					.css({ "max-height" : "150px", "overflow-y" : "auto" })
					.append($.createHtmlElement("p").addClass("menuFilterCaption").text("Фильтр: Форматы проверки: "));
			
			$inspectionFormats.each(function() {
				var key = $(this).attr("key");
				$inspectionFormatsGroup.append(
					$.createHtmlElement("p").addClass("menuFilter").append(
						$.createHtmlElement("input")
							.attr("id", key)
							.attr("name", "inspectionFormatsGroup")
							.attr("type", "checkbox")
							.removeAttr("checked")
							.change(showQuestions)
					).append(
						$.createHtmlElement("label").attr("for", key).text($(this).attr("name"))
					)
				);
			});
			
			$leftPanel.append($inspectionFormatsGroup);
		}
		
		if ((vizitType === "VT_AUDIT") || (vizitType === "VT_GEMBA")) {
			var $showOptionsGroup = $.createHtmlElement("div").attr("id", "showOptionsGroup")
				.append($.createHtmlElement("p").addClass("menuFilterCaption").text("Опции показа: "));
			
			$previousData.children("showOptions").children("showOption").each(function() {
				var key = $(this).attr("key");
				$showOptionsGroup.append(
					$.createHtmlElement("p").addClass("menuFilter").append(
						$.createHtmlElement("input")
							.attr("id", key)
							.attr("name", "showOptionsGroup")
							.attr("type", "radio")
							.removeAttr("checked")
							.change(showQuestions)
					).append(
						$.createHtmlElement("label").attr("for", key).text($(this).attr("name"))
					)
				);
			});
			
			$showOptionsGroup.find("input").filter(":first").attr("checked", "checked");
			$leftPanel.append($showOptionsGroup);
		}
	}
	
	//var time = 0;
	
	$template.children("blocks").children("block").each(function() {
		var $block = $(this);
		var blockId = $block.attr("id");
		var blockElementId = "odcl-bl-" + blockId;
		
		var subbranchId = $block.children("subbranch").attr("id");
		var levelKey = $block.children("subbranch").children("level").attr("key");
		
		if (!((levelKey === "SL_CA") || (levelKey === "SL_TB") && (subbranchId === employeeTbSubbranch))) {
			return; // continue
		}
		if ((mvsAreaFlag != null) && (mvsAreaFlag === "false")) {
			if ($block.find("question metric").filter("[key ^= 'M_MVS_']").size() > 0) {
				return; // continue
			}
		}
		
		blockMap[blockId] = $block;
		
		$leftPanel.append($.createHtmlElement("div")
								.attr("id", blockElementId)
								.addClass("menuBlock menuGroup od-collapse")
								.text($block.attr("name")));
		// Контейнер групп
		$menuGroup = $.createHtmlElement("div")
								.attr("id", blockElementId + "-cnt")
								.addClass("od-hidden ID" + blockElementId);
		
		var $blockMetrics = $block.children("metrics").children("metric");
		$blockMetrics.attr("max", 0.0);
		$blockMetrics.attr("value", 0.0);
		
		$block.children("groups").children("group").each(function() {
			var $group = $(this);
			var groupId = $group.attr("id");
			var groupElementId = blockElementId + "-gr-" + groupId;
			
			$blockMetrics.each(function() {
				var $metric = $(this);
				var metricKey = $metric.attr("key");
				
				if ((metricKey === "M_QUALITY") || (metricKey === "M_MVS_QUALITY")) {
					$group.attr("m-" + $metric.attr("id") + "-max", 0.0);
				}
			});
			
			$menuGroup.append($.createHtmlElement("div")
							.attr("id", groupElementId)
							.addClass("menuGroup menu-sub")
							.text($group.attr("name")));
			
			$group.children("questions").children("question").each(function() {
				var $question = $(this);
				var questionId = $question.attr("id");
				var questionElementId = groupElementId + "-q-" + questionId;
				var $questionMetrics = $question.children("questionMetrics");
				var hasResultMetric = false;
				
				questionMap[questionId] = $question;
				questionGroupMap[questionId] = groupId;
				
				//var start = new Date().getTime();
				$blockMetrics.each(function() {
					var $metric = $(this);
					var metricId = $metric.attr("id");
					var metricKey = $metric.attr("key");
					var points = $questionMetrics.find("metric[id = '" + metricId + "']").attr("max");
					
					if (points != null) {
						if (metricKey === "M_RESULT") {
							$metric.attr("max", parseFloat($metric.attr("max")) + parseFloat(points));
							hasResultMetric = true;
							
						} else if ((metricKey === "M_QUALITY_CHECKUP") 
								|| (metricKey === "M_STANDARDS") || (metricKey === "M_MVS_STANDARDS") 
								|| (metricKey === "M_SALES_TECH") || (metricKey === "M_MVS_SALES_TECH") 
								|| (metricKey === "M_KNOWLEDGE") || (metricKey === "M_MVS_KNOWLEDGE")) {
							
							$metric.attr("max", parseFloat($metric.attr("max")) + parseFloat(points));
							
						} else if ((metricKey === "M_QUALITY") || (metricKey === "M_MVS_QUALITY")) {
							var groupMetricAttr = "m-" + metricId + "-max";
							$group.attr(groupMetricAttr, parseFloat($group.attr(groupMetricAttr)) + parseFloat(points));
						}
					}
				});
				//time += (new Date().getTime() - start);
				var $questionElement = $.createHtmlElement("div")
											.attr("id", questionElementId)
											.addClass("QuestionPanel ID" + groupElementId);
				
				var $questionAnswerField = $.createHtmlElement("div").addClass("question_result").css("align", "center");
				var $buttonField = $.createHtmlElement("div").addClass("buttonActivityContainer");
				var $activityInfoField = $.createHtmlElement("div");
				
				var $questionActivities = $activities.filter("[questionId = '" + questionId + "']");
				if ($questionActivities.size() > 0) {
					$activityInfoField.append($.createHtmlElement("p").text("Мероприятия: "));
					
					var $activityList = $.createHtmlElement("ul").addClass("activityList");
					$questionActivities.each(function() {
						var text = $(this).attr("name") + " (до " + $(this).attr("dueDate") + ")";
						$activityList.append($.createHtmlElement("li").append($.createActivityLink($(this).attr("id"), text)));
					});
					$activityInfoField.append($activityList);
				}
				
				var dependOnId = $question.attr("dependOnId");
				if (dependOnId != null) {
					$questionElement.addClass("dependent");
					
					if (typeof dependentMap[dependOnId] === "undefined") {
						dependentMap[dependOnId] = [];
					}
					dependentMap[dependOnId].push({ "id" : questionId, "itemId" : $question.children("dependOnItem").attr("id") });
				}
				
				var $maxPoints = null;
				if (hasResultMetric) {
					var points = $questionMetrics.find("metric[key = 'M_RESULT']").attr("max");
					if (points > 0) {
						$maxPoints = $.createHtmlElement("div").css('float', 'right').html("Вес вопроса: " + addPointText(points));
					}
				}
				
				$questionElement.append(
					$.createHtmlElement("table").append(
						$.createHtmlElement("tr").append(
							$.createHtmlElement("td").attr("width", "60%").append(
								$.createHtmlElement("div")
									.addClass("question")
									.html($question.attr("number") + ". " + $question.children("text").text() + 
											((vizitType !== "VT_GEMBA") && ($question.attr("mandatory") === "true") ||
											 (vizitType === "VT_GEMBA") && ($question.attr("mandatoryManagement") === "true")
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
				var $storedAnswer = $storedAnswers.filter("[questionId = '" + questionId + "']");
				var $previousAnswer = $previousAnswers.filter("[questionId = '" + questionId + "']");
				
				$question.attr("answerId", $storedAnswer.attr("id"));
				
				if (answerType === "AT_STRING") {
					var $stringElement = $.createHtmlElement("input")
							.attr("name", questionElementId)
							.attr("type", "text")
							.attr("maxlength", "2000")
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
							
				} else if (answerType === "AT_NUMERIC") {
					var $numericElement = $.createHtmlElement("input")
							.attr("name", questionElementId)
							.attr("type", "text")
							.attr("maxlength", "15")
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

				} else if (answerType === "AT_DATE") {
					var $dateElement = $.createHtmlElement("input")
							.attr("name", questionElementId)
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

				} else if (answerType === "AT_MEMO") {
					var $memoElement = $.createHtmlElement("textarea")
							.attr("cols", "40").attr("rows", "10")
							.attr("name", questionElementId)
							.attr("maxlength", "2000")
							.val($storedAnswer.children("stringValue").text())
							.change(function() {
								answersChanged = true;
							});
					if (readOnly && (taskId != null)) {
						$memoElement.attr("disabled", true);
					}
					$questionAnswerField.append($memoElement);

				} else if (answerType === "AT_DDLIST-ONE") {
					var storedItemId = $storedAnswer.children("items").children("item").attr("id");
					var previousItemId = $previousAnswer.children("items").children("item").attr("id");
					var $selectElement = $.createHtmlElement("select")
							.attr("name", questionElementId)
							.change(function() {
								answersChanged = true;
								countMetrics();
							})
							.change({ "question" : $question, "questionId" : questionId }, showDependencies);
					
					$question.children("dic").children("items").children("item").each(function() {
						var $item = $(this);
						var itemId = $item.attr("id");
						var itemName = $item.attr("name");
						var answerItemId = questionElementId + "_" + itemId;
						
						var $optionElement = $.createHtmlElement("option")
												.attr("id", answerItemId)
												.val(itemName).text(itemName);
						if (itemId === storedItemId) {
							$optionElement.attr("selected", "selected");
						} else {
							$optionElement.removeAttr("selected");
						}
						if (itemId === previousItemId) {
							$optionElement.css("font-weight", "bold");
						}
						if (readOnly && (taskId != null)) {
							$optionElement.attr("disabled", true);
						}
						
						$selectElement.append($optionElement);
					});
					
					if (($selectElement.find("option").val() != null) && ($selectElement.find(":selected").val() == null)) {
						$selectElement.find("option:first").attr("selected", "selected");
					}
					
					$questionAnswerField.append($selectElement);
					
				} else if (answerType === "AT_CHECKLIST") {
					var $items = $question.children("dic").children("items").children("item");
					var $storedItems = $storedAnswer.children("items").children("item");
					var $previousItems = $previousAnswer.children("items").children("item");
					
					$items.each(function() {
						var $item = $(this);
						var itemId = $item.attr("id");
						var answerItemId = questionElementId + "_" + itemId;
						
						var $checkboxElement = $.createHtmlElement("input")
												.attr("id", answerItemId)
												.attr("name", questionElementId)
												.attr("type", "checkbox")
												.change(function() {
													answersChanged = true;
													countMetrics();
												})
												.change({ "question" : $question, "questionId" : questionId }, showDependencies);
						
						if ($storedItems.filter("[id = '" + itemId + "']").size() === 1) {
							$checkboxElement.attr("checked", "checked");
						} else {
							$checkboxElement.removeAttr("checked");
						}
						if (readOnly && (taskId != null)) {
							$checkboxElement.attr("disabled", true);
						}
						
						var $checkboxElementLabel = $.createHtmlElement("label")
												.attr("for", answerItemId)
												.text($item.attr("name"));
						if ($previousItems.filter("[id = '" + itemId + "']").size() === 1) {
							$checkboxElement.css("font-weight", "bold");
						}
						$questionAnswerField.append($.createHtmlElement("p").append($checkboxElement).append($checkboxElementLabel));
					});
					
				} else if (answerType === "AT_RADIO") {
					var $items = $question.children("dic").children("items").children("item");
					var storedItemId = $storedAnswer.children("items").children("item").attr("id");
					var previousItemId = $previousAnswer.children("items").children("item").attr("id");
					
					$items.each(function() {
						var $item = $(this);
						var itemId = $item.attr("id");
						var answerItemId = questionElementId + "_" + itemId;
						
						var $radioElement = $.createHtmlElement("input")
												.attr("id", answerItemId)
												.attr("name", questionElementId)
												.attr("type", "radio")
												.change(function() {
													answersChanged = true;
													countMetrics();
												})
												.change({ "question" : $question, "questionId" : questionId }, showDependencies);
						
						if ((itemId === storedItemId) || (itemId === previousItemId) && (storedItemId == null)) {
							$radioElement.attr("checked", "checked");
						} else {
							$radioElement.removeAttr("checked");
						}
						if (readOnly && (taskId != null)) {
							$radioElement.attr("disabled", true);
						}
						if ((vizitType === "VT_AUDIT") || (vizitType === "VT_GEMBA")) {
							if ((previousItemId == null) || (previousItemId === "") 
									|| ($items.filter("[id = '" + previousItemId + "']").attr("positive") === "false")) {
								if ($item.attr("positive") === "true") {
									$radioElement.attr("disabled", true);
								}
							}
						}
						
						var $radioElementLabel = $.createHtmlElement("label")
												.attr("for", answerItemId)
												.text($item.attr("name"));
						if (itemId === previousItemId) {
							$radioElementLabel.css("font-weight", "bold");
						}
						
						$questionAnswerField.append($.createHtmlElement("p").append($radioElement).append($radioElementLabel));
					});
				}
				
				if ($question.attr("activityCreation") === "true") {
					var $activityButton = $.createActivityButton(questionId);
					if (readOnly) {
						$activityButton.attr("disabled", true);
					}
					$buttonField.append($activityButton);
				}
				
				questionPanelMap[questionId] = $questionElement;
				
				$rightPanel.append($questionElement);
			});
			
			$leftPanel.append($menuGroup);
		});
	});
	
	$rightPanel.append(
		$.createHtmlElement("a")
			.addClass("upPagePanel").css("display", "block")
			.attr("href", "#top").attr("title", "Наверх")
			.text("Наверх страницы")
			.click(function() {
				$("#rightPanel").animate({ scrollTop : 0 }, "slow"); return false;
			})
	);
	
	//$("#checklistForm\\:checklistBody").html($root.html());
	//console.log("TIME blockMetrics = ", time);
	//console.log("TIME DURATION = ", (new Date().getTime() - start));
	
	$(".menuBlock").click(function() {
		var instance = $(this);
		
		$(".menuBlock").not(instance).each(function() {
			collapseBlock($(this));
		});
		
		if (instance.hasClass("od-collapse")) {
			expandBlock(instance);
			
			countMetrics();
			// Сдвигаем вопросы на текущую высоту таблицы показателей
			$("#rightPanel").css({ "top" : $("#metricTable").height() + 10 });
			
			// Открываем первую группу в блоке
			$(".menu-sub[id ^= '" + instance.attr("id") + "-gr-']").first().click();
		}
	});
	
	//$(".QuestionPanel").hide().removeClass("od-hidden");
	
	$(".menu-sub").click(function() {
		var instance = $(this);
		$(".menu-sub").not(instance).removeClass("od-selected");
		$(".QuestionPanel").hide();
		$(".ID" + instance.attr("id")).not(".dependent").show();
		instance.addClass("od-selected");
		if ((vizitType === "VT_SELF") || (vizitType === "VT_AUDIT") || (vizitType === "VT_GEMBA")) {
			showQuestions();
		}
		$("#rightPanel").animate({ scrollTop : 0 }, "fast");
	});
	
	$(".menuBlock").first().click();
	//console.log("TIME FULL = ", (new Date().getTime() - start));
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
	var $storedAnswers = $previousData.children("storedAnswers");
	var $blockMetrics = $previousData.children("blockMetrics");
	
	$storedAnswers.find("answer").remove();
	
	for (var questionId in questionMap) {
		var $question = questionMap[questionId];
		var $questionPanel = questionPanelMap[questionId];
		
		var $answer = $.createXmlElement("answer");
		$answer.attr("id", $question.attr("answerId"));
		$answer.attr("questionId", questionId);
		$answer.attr("taskId", taskId);
		var answerType = $question.children("answerType").attr("key");
		
		if (answerType === "AT_NUMERIC") {
			$answer.append($.createXmlElement("numberValue").text($questionPanel.find("input").val()));
			
		} else if (answerType === "AT_DATE") {
			$answer.append($.createXmlElement("dateValue").text($questionPanel.find("input").val()));
			
		} else if (answerType === "AT_STRING") {
			$answer.append($.createXmlElement("stringValue").text($questionPanel.find("input").val()));
			
		} else if (answerType === "AT_MEMO") {
			$answer.append($.createXmlElement("stringValue").text($questionPanel.find("textarea").val()));
			
		} else if (answerType === "AT_DDLIST-ONE") {
			var $items = $.createXmlElement("items");
			
			var itemId = $questionPanel.find(":selected").attr("id");
			if (itemId != null) {
				itemId = itemId.substring(itemId.lastIndexOf("_") + 1);
				$items.append($question.find("dic item[id = '" + itemId + "']").clone());
			}
			
			$answer.append($items.clone());
			
		} else if ((answerType === "AT_RADIO") || (answerType === "AT_CHECKLIST")) {
			var $items = $.createXmlElement("items");
			
			$questionPanel.find("input:checked").each(function() {
				var itemId = $(this).attr("id");
				itemId = itemId.substring(itemId.lastIndexOf("_") + 1);
				$items.append($question.find("dic item[id = '" + itemId + "']").clone());
			});
			
			$answer.append($items.clone());
		}
		
		$storedAnswers.append($answer.clone());
	}
	
	$blockMetrics.find("blockMetric").remove();
	
	for (var blockId in blockMap) {
		var $block = blockMap[blockId];
		
		$block.children("metrics").children("metric").each(function() {
			var $metric = $(this);
			var metricValue = $metric.attr("value");
			
			if (metricValue != null) {
				var $blockMetric = $.createBlockMetric(blockId, $metric.attr("id"), null, metricValue);
				$blockMetrics.append($blockMetric.clone());
				
				if ( ( (vizitType === "VT_AUDIT") || (vizitType === "VT_GEMBA") ) && ($metric.attr("key") === "M_RESULT") ) {
					var dispersion = (previousValue > 0) ? (1 - metricValue / previousValue) : 0;
					var reduction = $reduceIndexes.filter(function(index) {
						return ($(this).attr("dispStartValue") < dispersion) && ($(this).attr("dispEndValue") >= dispersion);
					}).attr("value");
					reduction = (reduction == null) ? 1 : reduction;
					var dispersedResult = metricValue * reduction;
					
					var $blockMetric = $.createBlockMetric(blockId, null, "M_DISPERSION", dispersion);
					$blockMetrics.append($blockMetric.clone());
					
					var $blockMetric = $.createBlockMetric(blockId, null, "M_REDUCE_INDEX", reduction);
					$blockMetrics.append($blockMetric.clone());
					
					var $blockMetric = $.createBlockMetric(blockId, null, "M_DISPERSED_RESULT", dispersedResult);
					$blockMetrics.append($blockMetric.clone());
				}
			}
		});
	}
	
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
		var blockId = menuBlockId.substring(menuBlockId.indexOf("-bl-") + 4);
		var $block = blockMap[blockId];
		
		$block.children("metrics").children("metric").each(function() {
			var $metric = $(this);
			var metricId = $metric.attr("id");
			var metricKey = $metric.attr("key");
			
			$metric.attr("value", 0.0);
			
			$block.find("group").each(function() {
				var $group = $(this);
				var groupPoints = 0.0;
				
				$group.find("question").each(function() {
					var $question = $(this);
					var questionId = $question.attr("id");
					var answerType = $question.children("answerType").attr("key");
					var $items = null;
					
					if ((answerType === "AT_RADIO") || (answerType === "AT_CHECKLIST")) {
						$items = questionPanelMap[questionId].find("input:checked");
						
					} else if (answerType === "AT_DDLIST-ONE") {
						$items = questionPanelMap[questionId].find(":selected");
					}
					
					if ($items != null) {
						$items.each(function() {
							var itemId = $(this).attr("id");
							itemId = itemId.substring(itemId.lastIndexOf("_") + 1);
							
							var points = $question.find("metricItem").filter(function(index) {
								var $id = $(this).children("id");
								return 	($id.attr("metricId") === metricId) && ($id.attr("itemId") === itemId);
							}).attr("answerPoints");
							points = (points == null) ? 0.0 : points;
							
							if ((metricKey === "M_RESULT") || (metricKey === "M_QUALITY_CHECKUP") 
									|| (metricKey === "M_STANDARDS") || (metricKey === "M_MVS_STANDARDS") 
									|| (metricKey === "M_SALES_TECH") || (metricKey === "M_MVS_SALES_TECH") 
									|| (metricKey === "M_KNOWLEDGE") || (metricKey === "M_MVS_KNOWLEDGE")) {
								
								$metric.attr("value", parseFloat($metric.attr("value")) + parseFloat(points));
	
							} else if ((metricKey === "M_QUALITY") || (metricKey === "M_MVS_QUALITY")) {
								groupPoints = parseFloat(groupPoints) + parseFloat(points);
							}
						});
					}
					
					if (answerType === "AT_NUMERIC") {
						var value = questionPanelMap[questionId].find("input").val();
						
						var points = $question.find("answerRange").filter(function(index) {
							var $range = $(this).children("range");
							return 	($range.attr("startValue") <= value) && ($range.attr("endValue") >= value);
						}).attr("answerPoints");
						points = (points == null) ? 0.0 : points;
						
						if (metricKey === "M_RESULT") {
							$metric.attr("value", parseFloat($metric.attr("value")) + parseFloat(points));
						}
					}
				});
				
				if ((metricKey === "M_QUALITY") || (metricKey === "M_MVS_QUALITY")) {
					var rate = $group.find("groupMetric metric[id = '" + metricId + "']").parent().attr("rate");
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
function createTable($block) {
	var $metricTable = $("#metricTable");
	$metricTable.find("tr").remove();
	
	$block.children("metrics").children("metric").each(function() {
		var $metric = $(this);
		var metricKey = $metric.attr("key");
		var metricMax = $metric.attr("max");
		var metricValue = $metric.attr("value");
		
		if ((vizitType === "VT_SELF") || (vizitType === "VT_AUDIT") || (vizitType === "VT_GEMBA")) {
			if (metricKey === "M_RESULT") {
				var targetValue = Math.round(metricMax * targetPercent);
				var color = (metricValue < targetValue) ? "red" : "white";
				
				$metricTable.append(
					$.createHtmlElement("tr").append(
						$.createHtmlElement("td").attr("width", "220").text("Максимальная сумма баллов:")
					).append(
						$.createHtmlElement("td").attr("width", "180").text(addPointText(metricMax))
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
								((targetValue !== 0) ? (" (" + Math.round(previousValue * 100 / targetValue) + "% от цели)") : ""))
					).append(
						$.createHtmlElement("td").text("Результат текущей проверки:")
					).append(
						$.createHtmlElement("td").text(addPointText(metricValue) + 
								((targetValue !== 0) ? (" (" + Math.round(metricValue * 100 / targetValue) + "% от цели)") : ""))
								.css("color", color)
					)
				);
				
				if (vizitType !== "VT_SELF") {
					var dispersionDiff = (previousValue > 0) ? (previousValue - metricValue) : 0;
					var dispersion = (previousValue > 0) ? (dispersionDiff / previousValue) : 0;
					var reduction = $reduceIndexes.filter(function(index) {
						return ($(this).attr("dispStartValue") < dispersion) && ($(this).attr("dispEndValue") >= dispersion);
					}).attr("value");
					reduction = (reduction == null) ? 1 : reduction;
					
					$metricTable.append(
						$.createHtmlElement("tr").append(
							$.createHtmlElement("td").text("Текущая дисперсия:")
						).append(
							$.createHtmlElement("td").text(addPointText(dispersionDiff) + " (" + addPercent(dispersion) + ")")
						).append(
							$.createHtmlElement("td").text("Понижающий коэффициент:")
						).append(
							$.createHtmlElement("td").text(reduction)
						)
					).append(
						$.createHtmlElement("tr").append(
							$.createHtmlElement("td").text("Результат с учетом дисперсии:")
						).append(
							$.createHtmlElement("td").text(addPointText(Math.round(100 * metricValue * reduction) / 100))
						).append(
							$.createHtmlElement("td").text("Рейтинг:")
						).append(
							$.createHtmlElement("td").text(addPercent(metricValue * reduction / metricMax))
						)
					);
					
				} else {
					$metricTable.append(
						$.createHtmlElement("tr").append(
							$.createHtmlElement("td").attr("colspan", "2").css("text-align", "right").text("Рейтинг:")
						).append(
							$.createHtmlElement("td").attr("colspan", "2").text(addPercent(metricValue / metricMax))
						)
					);
				}
			}
			
		} else {
			if (metricKey === "M_RESULT") {
				$metricTable.append(
					$.createHtmlElement("tr").append(
						$.createHtmlElement("td").attr("width", "400").text($metric.attr("name"))
					).append(
						$.createHtmlElement("td").attr("width", "400").text(addPointText(metricValue) + " (" + addPercent(metricValue / metricMax) + ")")
					)
				);
				
			} else if ((metricKey === "M_STANDARDS") || (metricKey === "M_MVS_STANDARDS") 
					|| (metricKey === "M_SALES_TECH") || (metricKey === "M_MVS_SALES_TECH") 
					|| (metricKey === "M_KNOWLEDGE") || (metricKey === "M_MVS_KNOWLEDGE") 
					|| (metricKey === "M_QUALITY") || (metricKey === "M_MVS_QUALITY")
					|| (metricKey === "M_QUALITY_CHECKUP")) {
				
				if ((metricMax != null) && (metricMax > 0)) {
					$metric.attr("value", metricValue / metricMax);
				}
				$metricTable.append(
					$.createHtmlElement("tr").append(
						$.createHtmlElement("td").attr("width", "400").text($metric.attr("name"))
					).append(
						$.createHtmlElement("td").attr("width", "400").text(addPercent($metric.attr("value")))
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
	var $formats = $allFormats.find(":checked");
	
	$(".QuestionPanel.ID" + $(".menu-sub.od-selected").attr("id")).each(function() {
		var $questionBlock = $(this);
		var questionBlockId = $questionBlock.attr("id");
		var questionId = questionBlockId.substring(questionBlockId.indexOf("-q-") + 3);
		
		var visible = true;
		
		if ($allFormats.length > 0) {
			if ($formats.length > 0) {
				var $questionFormats = questionMap[questionId].find("inspectionFormat");
				
				$questionFormats = $questionFormats.filter(function(index) {
					return ($formats.filter("[id = '" + $(this).attr("key") + "']").attr("id") != null);
				});
				
				visible &= ($questionFormats.size() > 0);
			}
		}
		
		if (option != null) {
			var $answers = ($previousAnswers.size() > 0) ? $previousAnswers : $storedAnswers;
			var $item = $answers.filter("[questionId = '" + questionId + "']").find("item");
			
			if (option === "DI_SHOW_OPTION_YES") {
				visible &= ($item.attr("key") === "DI_YES_CERTIFICATION");
				
			} else if (option === "DI_SHOW_OPTION_NO") {
				visible &= ($item.attr("key") === "DI_NO_CERTIFICATION");
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
	var questionId = event.data.questionId;
	
	if (typeof dependentMap[questionId] !== "undefined") {
		var list = dependentMap[questionId];
		var answerType = $question.children("answerType").attr("key");
		var $items = null;
		
		if ((answerType === "AT_RADIO") || (answerType === "AT_CHECKLIST")) {
			$items = questionPanelMap[questionId].find(" input:checked");
			
		} else if (answerType === "AT_DDLIST-ONE") {
			$items = questionPanelMap[questionId].find(" :selected");
		}
		
		$question.children("dic").children("items").children("item").each(function() {
			var $item = $(this);
			var itemId = $item.attr("id");
			
			for (var i = 0, l = list.length; i < l; i++) {
				var dependentId = list[i].id;
				var dependentItemId = list[i].itemId;
				
				if (dependentItemId === itemId) {
					if ($items.filter("[id $= '_" + itemId + "']").size() !== 0) {
						questionPanelMap[dependentId].removeClass("dependent");
						if (questionGroupMap[dependentId] === questionGroupMap[questionId]) {
							questionPanelMap[dependentId].show();
						}
						
						showDependentQuestions(questionMap[dependentId], dependentId, questionGroupMap[questionId]);
						
					} else {
						questionPanelMap[dependentId].addClass("dependent");
						if (questionGroupMap[dependentId] === questionGroupMap[questionId]) {
							questionPanelMap[dependentId].hide();
						}
						
						hideDependentQuestions(dependentId, questionGroupMap[questionId]);
					}
				}
			}
		});
	}
};

/******************************************************************************
 * Description: 
 * Return: 		
 *****************************************************************************/
function showDependentQuestions($question, questionId, currentGroupId) {
	if (typeof dependentMap[questionId] !== "undefined") {
		var list = dependentMap[questionId];
		var answerType = $question.children("answerType").attr("key");
		var $items = null;
		
		if ((answerType === "AT_RADIO") || (answerType === "AT_CHECKLIST")) {
			$items = questionPanelMap[questionId].find(" input:checked");
			
		} else if (answerType === "AT_DDLIST-ONE") {
			$items = questionPanelMap[questionId].find(" :selected");
		}
		
		$question.children("dic").children("items").children("item").each(function() {
			var $item = $(this);
			var itemId = $item.attr("id");
			
			for (var i = 0, l = list.length; i < l; i++) {
				var dependentId = list[i].id;
				var dependentItemId = list[i].itemId;
				
				if (dependentItemId === itemId) {
					if ($items.filter("[id $= '_" + itemId + "']").size() !== 0) {
						questionPanelMap[dependentId].removeClass("dependent");
						if ((questionGroupMap[questionId] === currentGroupId)
								&& (questionGroupMap[dependentId] === currentGroupId)) {
							questionPanelMap[dependentId].show();
						}
						
						showDependentQuestions(questionMap[dependentId], dependentId, questionGroupMap[questionId]);
					}
				}
			}
		});
	}
};

/******************************************************************************
 * Description: 
 * Return: 		
 *****************************************************************************/
function hideDependentQuestions(questionId, currentGroupId) {
	if (typeof dependentMap[questionId] !== "undefined") {
		var list = dependentMap[questionId];
		for (var i = 0, l = list.length; i < l; i++) {
			var dependentId = list[i].id;
			
			questionPanelMap[dependentId].addClass("dependent");
			if ((questionGroupMap[questionId] === currentGroupId)
					&& (questionGroupMap[dependentId] === currentGroupId)) {
				questionPanelMap[dependentId].show();
			}
			
			hideDependentQuestions(dependentId, currentGroupId);
		}
	}
};

/******************************************************************************
 * Description: function checks questions with mandatory answers
 * Return: 		true - when all mandatory fields are filled, 
 * 				false - otherwise (not all mandatory fields are filled)
 *****************************************************************************/
function ValidateCL() {
	var fulfilled = true;
	
	for (var questionId in questionMap) {
		var $question = questionMap[questionId];
		
		if ((vizitType !== "VT_GEMBA") && ($question.attr("mandatory") === "true")
				|| (vizitType === "VT_GEMBA") && ($question.attr("mandatoryManagement") === "true")) {
			var $questionPanel = questionPanelMap[questionId];
			var answerType = $question.children("answerType").attr("key");
			
			if ((answerType === "AT_NUMERIC") || (answerType === "AT_DATE") || (answerType === "AT_STRING")) {
				if ($.trim($questionPanel.find("input").val()) == "") {
					fulfilled = false;
					$questionPanel.addClass("shouldBeAnswered");
					// return false; // break
					
				} else {
					$questionPanel.removeClass("shouldBeAnswered");
				}
				
			} else if (answerType === "AT_MEMO") {
				if ($.trim($questionPanel.find("textarea").val()) == "") {
					fulfilled = false;
					$questionPanel.addClass("shouldBeAnswered");
					// return false; // break
					
				} else {
					$questionPanel.removeClass("shouldBeAnswered");
				}
				
			} else if (answerType === "AT_DDLIST-ONE") {
				if ($questionPanel.find(":selected").val() == null) {
					fulfilled = false;
					$questionPanel.addClass("shouldBeAnswered");
					// return false; // break
					
				} else {
					$questionPanel.removeClass("shouldBeAnswered");
				}
				
			} else if ((answerType === "AT_RADIO") || (answerType === "AT_CHECKLIST")) {
				if ($questionPanel.find("input:checked").val() == null) {
					fulfilled = false;
					$questionPanel.addClass("shouldBeAnswered");
					// return false; // break
					
				} else {
					$questionPanel.removeClass("shouldBeAnswered");
				}
			}
		}
	}
	
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
					var $question = questionMap[questionId];
					var $questionPanel = questionPanelMap[questionId];
					var answerType = $question.children("answerType").attr("key");
					var itemId = null;
					
					if (answerType === "AT_DDLIST-ONE") {
						itemId = $questionPanel.find(":selected").attr("id");
						if (itemId != null) {
							itemId = itemId.substring(itemId.lastIndexOf("_") + 1);
						}
						
					} else if (answerType === "AT_RADIO") {
						itemId = $questionPanel.find("input:checked").attr("id");
						if (itemId != null) {
							itemId = itemId.substring(itemId.lastIndexOf("_") + 1);
						}
					}
					addActivity(questionId, U(itemId));
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
//TODO
$.createHtmlFragment = function(name) {
	var fr = document.createDocumentFragment();
	fr.appendChild(document.createElement(name));
	return {fr: fr, ch: $(fr).children()};
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
		if (this[i] === obj) {
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
	var tagShow = tag.charAt(0) !== "#";
	if (tagShow) {
		res += '<' + tag;
	}
	if (el.attributes) {
		res += $.map(
				el.attributes,
				function(attr) {
					if (attr.specified && attr.name.charAt(0) !== '$')
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
	if (typeof (val) === "undefined") {
		return "";
	}
	return val;
};

/******************************************************************************
 * Description: 
 * Return: 		
 *****************************************************************************/
function addPointText(points) {
	var unit = points % 10;
	var tens = Math.round(points / 10);
	var text = points + " балл";
	
	if ((tens !== 1) && (unit === 1)) {
		
	} else if ((tens !== 1) && (unit >= 2) && (unit <= 4)) {
		text += "а";
	} else {
		text += "ов";
	}
	
	return text;
};

function addPercent(value) {
	return Math.round(10000 * value) / 100 + " %";
};